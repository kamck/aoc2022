require_relative 'hardware/clock_circuit'
require_relative 'hardware/device'
require_relative 'hardware/display'

device = Device.new(ClockCircuit.new, Display.new)

ARGF.map(&:split).each { |inst, val| device.execute(inst, val) }
