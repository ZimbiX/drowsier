module Drowsier
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
      time_within?(config.lockdown_start_at, config.lockdown_end_at, now)
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
      system.pause_media!
      system.lock_screen!
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
    end

    private getter system do
      System.new(config)
    end

    private getter hours, minutes, seconds, config
  end
end
