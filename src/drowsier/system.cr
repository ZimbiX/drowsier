module Drowsier
  class System
    def initialize(@config : Config)
      @output = IO::Memory.new
    end

    def lock_screen! : Void
      puts "Locking screen"
      run(config.lock_screen_command).wait
    end

    def turn_off_screen! : Void
      puts "Turning off screen"
      run(config.turn_off_screen_command).wait
    end

    def turn_on_screen! : Void
      puts "Turning off screen"
      run(config.turn_on_screen_command).wait
    end

    def screen_off? : Bool
      run(config.check_if_screen_is_off_command).wait
        .success?.tap { |off| puts(off ? "Screen is off" : "Screen is on") }
    end

    def pause_media! : Void
      run(config.pause_media_command).wait
    end

    def play_audio_notification! : Void
      stop_existing_audio_notification!
      @audio_notification_process = run(config.play_audio_notification_command)
    end

    def startup_ready? : Bool
      run(config.system_startup_readiness_check_command).wait
        .tap do |result|
          if result.success?
            puts "System is ready"
          else
            puts output.to_s
            puts "System is not ready"
          end
        end
        .success?
    end

    private def stop_existing_audio_notification! : Void
      audio_notification_process.try &.terminate
    end

    private def run(command)
      puts "+ " + command
      @output.clear
      Process.new(command, shell: true, output: output, error: output)
    end

    private getter config
    private getter output

    private property audio_notification_process : Process?
  end
end
