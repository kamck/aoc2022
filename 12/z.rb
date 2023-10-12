require_relative 'lib/chart'

def load_input
	ARGF.map { |line| line.chomp.chars }.reverse
end

def pathfind(chart, start)
	queue = [[start]]
	explored = [chart.potential_starts]
	spaths = []

	while !queue.empty?
		v = queue.shift
		if chart.destination? v.last
			spaths << v
		else
			steps = chart.available_steps(v.last)
			steps.reject { |x| explored.member? x }.each do |x| 
				queue << v + [x]
				explored << x
			end
		end
	end

	spaths
end

chart = Chart.new(load_input)
spaths = chart.potential_starts.map do |start|
	pathfind(chart, start)
end

p spaths.size
p spaths.flatten(1).min_by(&:size).size - 1
