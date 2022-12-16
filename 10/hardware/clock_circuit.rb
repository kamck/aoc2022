class ClockCircuit
  CYCLES = { addx: 2, noop: 1 }

  attr_reader :cycle_count

  def tick(inst)
    @cycle_count ||= 0

    CYCLES[inst.to_sym].times do
      @cycle_count += 1
      yield
    end
  end
end
