class Clock
  @hour : Int32
  @minute : Int32

  def initialize(hour : Int32 = 0, minute : Int32 = 0)
    @hour = (hour + minute // 60) % 24
    @minute = minute % 60
  end

  def to_s() : String
    sprintf("%02d:%02d", @hour, @minute)
  end

  def +(other) : Clock
    Clock.new(@hour + other.@hour, @minute + other.@minute)
  end

  def -(other) : Clock
    Clock.new(@hour - other.@hour, @minute - other.@minute)
  end

  def ==(other) : Bool
    @hour == other.@hour && @minute == other.@minute
  end
end
