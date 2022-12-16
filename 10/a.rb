require_relative 'hardware/clock_circuit'
require_relative 'hardware/display'
require_relative 'hardware/device'

dev_null = IO.for_fd(IO.sysopen('/dev/null', 'a+'))

device = Device.new(
  1,
  ClockCircuit.new(0),
  Display.new(dev_null),
  []
)

ARGF.map(&:split).each { |inst, val| device.execute(inst, val) }
p device.sig_strengths.sum
