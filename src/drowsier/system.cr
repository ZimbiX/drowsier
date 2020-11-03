module Drowsier
  class System
    def initialize(@config : Config)
    end

    def lock_screen!
      puts "Locking screen"
      `#{config.lock_screen_command}`
    end

    def turn_off_screen!
      puts "Turning off screen"
      `#{config.turn_off_screen_command}`
    end

    def screen_off?
      `#{config.check_if_screen_is_off_command}`
      $?.success?.tap { |off| puts(off ? "Screen is off" : "Screen is on") }
    end

    def pause_media!
      `#{config.pause_media_command}`
    end

    def play_audio_notification!
      command_pieces = config.play_audio_notification_command.split(" ")
      Process.new(
        command_pieces[0],
        command_pieces[1..-1],
      )
    end

    private getter config
  end
end
