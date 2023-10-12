require_relative 'lib/chart'

def load_input
	ARGF.map { |line| line.chomp.chars }.reverse
end

def pathfind(chart, start)
	queue = [[start]]
	explored = [start]
	spaths = []

	while !queue.empty?
		v = queue.shift
		if chart.destination? v.last
			spaths << v
			next
		end

		chart.available_steps(v.last).reject { |x| explored.member? x }.each do |x| 
			queue << v + [x]
			explored << x
		end
	end

	return spaths
end

chart = Chart.new(load_input)
spaths = pathfind(chart, chart.start)
p spaths.min_by(&:size).size - 1
