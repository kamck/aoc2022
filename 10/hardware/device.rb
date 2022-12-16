Device = Struct.new(:reg_x, :clock, :display, :sig_strengths) do
  def execute(inst, val)
    clock.tick(inst) do
      sig_strengths << signal_strength if significant_cycle?
      display.tick reg_x
    end

    self.reg_x += val.to_i if inst == 'addx'
  end

  def significant_cycle? do
    (1..11).step(2).include? clock.cycle_count / 20.0
  end

  def signal_strength = reg_x * clock.cycle_count
end
