module Drowsier
  class DatelessTimePeriod
    def initialize(@start_at, @end_at)
    end

    getter start_at, end_at
  end
end
