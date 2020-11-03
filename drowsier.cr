require "yaml"

class Drowsier
  class DatelessTime
    def initialize(@hours : Int32, @minutes : Int32, @seconds : Int32 = 0)
    end

    def self.from_string(time_string) : DatelessTime
      time_elements = time_string.split(":")
      hours = time_elements[0].to_i
      minutes = time_elements[1].to_i
      seconds = time_elements.fetch(2, "0").to_i
      new(hours, minutes, seconds)
    end

    def ==(other)
      to_seconds == other.to_seconds
    end

    def <(other)
      to_seconds < other.to_seconds
    end

    def <=(other)
      to_seconds <= other.to_seconds
    end

    def to_seconds
      hours * 60 * 60 + minutes * 60 + seconds
    end

    def to_s
      "%02d:%02d:%02d" % [hours, minutes, seconds]
    end

    getter hours, minutes, seconds
  end

  class DatelessTimePeriod
    def initialize(@start_at, @end_at)
    end

    getter start_at, end_at
  end

  class Config
    include YAML::Serializable

    @[YAML::Field(key: "lockdown_start_at")]
    property lockdown_start_at_str : String

    @[YAML::Field(key: "lockdown_end_at")]
    property lockdown_end_at_str : String

    @[YAML::Field(key: "check_interval_seconds")]
    property check_interval_seconds : Int32

    @[YAML::Field(key: "force_screen_off_seconds")]
    property force_screen_off_seconds : Int32

    def lockdown_start_at_time
      DatelessTime.from_string(lockdown_start_at_str)
    end

    def lockdown_end_at_time
      DatelessTime.from_string(lockdown_end_at_str)
    end

    def to_s
      [
        "lockdown start: " + lockdown_start_at_time.to_s,
        "lockdown end:   " + lockdown_end_at_time.to_s,
      ].join("\n")
    end
  end

  module System
    def self.lock_screen
      `/usr/bin/loginctl lock-session`
    end

    def self.turn_off_screen
      `/usr/bin/xset dpms force off`
    end
  end

  class Watcher
    def initialize(@config : Config)
    end

    def run
      puts "Drowsier running!"
      puts
      puts "Config:"
      puts config.to_s

      loop do
        now_dated = Time.local
        now = dateless(now_dated)
        print "\nChecking #{now_dated.to_s}, +#{now_dated.millisecond}ms... "

        if lockdown_period?(now)
          puts "Sleep!"
          enact_lockdown!
        else
          puts "Ok"
        end

        sleep_until_start_of_next_interval
      end
    end

    private def dateless(now)
      DatelessTime.new(now.hour, now.minute, now.second)
    end

    private def time_within?(start_time, end_time, time)
      start_time <= time && time < end_time
    end

    private def lockdown_period?(now)
      time_within?(config.lockdown_start_at_time, config.lockdown_end_at_time, now)
    end

    private def sleep_until_start_of_next_interval
      sleep_seconds = seconds_until_start_of_next_interval
      puts "Will check again in %.2f seconds" % sleep_seconds
      sleep(sleep_seconds)
    end

    private def seconds_until_start_of_next_interval
      now_f = Time.local.to_unix_f
      interval = config.check_interval_seconds
      interval - now_f % interval
    end

    private def enact_lockdown!
      System.lock_screen
      actively_force_screen_off_for_configured_period!
    end

    private def actively_force_screen_off_for_configured_period!
      stop_at = Time.local + config.force_screen_off_seconds.seconds
      while Time.local < stop_at
        System.turn_off_screen
        sleep(1)
      end
    end

    private getter hours, minutes, seconds, config
  end
end

config = Drowsier::Config.from_yaml(File.read("config.yaml"))
Drowsier::Watcher.new(config).run
