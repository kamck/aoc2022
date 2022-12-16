class Device
  attr_reader :sig_strengths

  def initialize(clock, display)
    @clock = clock
    @display = display
    @reg_x = 1
    @sig_strengths = []
  end

  def execute(inst, val)
    @clock.tick(inst) do
      @sig_strengths << signal_strength if significant_cycle?
      @display.tick @reg_x
    end

    @reg_x += val.to_i if inst == 'addx'
  end

  private
    def significant_cycle?
      (1..11).step(2).include? @clock.cycle_count / 20.0
    end

    def signal_strength = @reg_x * @clock.cycle_count
end
