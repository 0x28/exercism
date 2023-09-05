# To Do: Define the class JuiceMaker
class JuiceMaker
  def self.debug_light_on?
    true
  end

  def initialize(fluid : Int32)
    @fluid = fluid
    @running = false
  end

  def start
    @running = true
  end

  def stop(minutes)
    @fluid -= minutes * 5
    @running = false
  end

  def running?
    @running
  end

  def add_fluid(fluid)
    @fluid += fluid
  end
end
