require_relative 'lib/configure_vm'
require_relative 'lib/chart'

def load_input
	ARGF.map { |line| line.chomp.chars }.reverse
end

chart = Chart.new(load_input)
spaths = Pathfinder.visit(chart, [[chart.start]], [chart.start])

p spaths.size
p spaths.min_by(&:size).size - 1
