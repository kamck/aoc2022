ClockCircuit = Struct.new(:cycle_count) do
  CYCLES = { addx: 2, noop: 1 }

  def tick(inst)
    CYCLES[inst.to_sym].times do
      self.cycle_count += 1
      yield
    end
  end
end
