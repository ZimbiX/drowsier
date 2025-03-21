module Drowsier
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

    def >(other)
      to_seconds > other.to_seconds
    end

    def >=(other)
      to_seconds >= other.to_seconds
    end

    def to_seconds
      hours * 60 * 60 + minutes * 60 + seconds
    end

    def to_s
      "%02d:%02d:%02d" % [hours, minutes, seconds]
    end

    getter hours, minutes, seconds
  end
end
