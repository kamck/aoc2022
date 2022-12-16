require_relative 'hardware/clock_circuit'
require_relative 'hardware/device'
require_relative 'hardware/display'

device = Device.new(
  1,
  ClockCircuit.new(0),
  Display.new,
  []
)

ARGF.map(&:split).each { |inst, val| device.execute(inst, val) }
