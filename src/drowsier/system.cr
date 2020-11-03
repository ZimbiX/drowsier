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

    private getter config
  end
end
