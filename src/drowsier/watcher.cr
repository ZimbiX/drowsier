require "./override"

module Drowsier
  class Watcher
    def initialize(@config : Config, @silent : Bool)
    end

    def run
      startup
      loop do
        enact_lockdown! if lockdown_period?
        sleep_until_start_of_next_interval
      end
    end

    def tty
      puts "Drowsier running check for TTY..." unless silent
      if lockdown_period?
        puts "Drowsier is enforcing lockdown!"
        exit 1 unless lockdown_override_code?
      end
    end

    private def startup
      puts "Drowsier starting up..."
      exit_if_system_not_ready!
      puts "Drowsier running!"
      puts
      puts "Config:"
      puts config.to_s
    end

    private def exit_if_system_not_ready!
      exit 1 unless system.startup_ready?
    end

    private def dateless(now)
      DatelessTime.new(now.hour, now.minute, now.second)
    end

    private def time_within?(start_time, end_time, time)
      start_time <= time && time < end_time
    end

    private def lockdown_period?
      now_dated = Time.local
      now = dateless(now_dated)
      print "Checking #{now_dated.to_s}, +#{now_dated.millisecond}ms... " unless silent

      time_within?(config.lockdown_start_at, config.lockdown_end_at, now).tap do |need_to_enact_lockdown|
        puts(need_to_enact_lockdown ? "Sleep!" : "Ok") unless silent
      end
    end

    private def sleep_until_start_of_next_interval
      sleep_seconds = seconds_until_start_of_next_interval
      puts "Will check again in %.2f seconds" % sleep_seconds
      sleep(sleep_seconds)
      puts
    end

    private def seconds_until_start_of_next_interval
      return config.check_interval_seconds unless config.align_to_interval

      now_f = Time.local.to_unix_f
      interval = config.check_interval_seconds
      interval - now_f % interval
    end

    private def enact_lockdown!
      system.pause_media!
      system.lock_screen! if config.lock_screen
      constantly_force_screen_off_for_configured_period!
    end

    private def constantly_force_screen_off_for_configured_period!
      stop_at = Time.local + config.force_screen_off_seconds.seconds
      puts "Continuously forcing screen off for %d seconds, until %s" % [config.force_screen_off_seconds, stop_at]
      while Time.local < stop_at
        unless system.screen_off?
          system.play_audio_notification!
          system.turn_off_screen!
        end
        sleep(1)
      end
      system.turn_on_screen! if config.turn_on_screen_after_forced_off_period
    end

    private def lockdown_override_code?
      Override.new(config).override?
    end

    private getter system do
      System.new(config)
    end

    private getter hours, minutes, seconds, config, silent
  end
end
