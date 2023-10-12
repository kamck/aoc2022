require_relative 'lib/chart_b'

def load_input
	ARGF.map { |line| line.chomp.chars }.reverse
end


def pathfind(chart, start, spaths)
	queue = [[start]]
	explored = chart.potential_starts

	while !queue.empty?
		v = queue.shift
		if chart.destination? v.last
puts "found dest"
			spaths << v
			next
		end

		chart.available_steps(v.last).reject { |x| explored.member? x }.each do |x| 
			queue << v + [x]
			explored << x
		end
	end
end

chart = Chart.new(load_input)
spaths = []
chart.potential_starts.each do |start|
	pathfind(chart, start, spaths)
end

p spaths
p spaths.min_by(&:size).size - 1
