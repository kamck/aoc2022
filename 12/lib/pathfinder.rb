class Pathfinder
	def self.visit(chart, queue, explored, spaths = [])
		return spaths if queue.empty?
		if chart.destination? queue.first.last
			return spaths + [queue.first]
		end

		steps = unexplored(chart.available_steps(queue.first.last), explored)
		queue_new = queue.slice(1..) + steps.map { queue.first + [_1] }
		explored_new = explored + [steps]
		visit chart, queue_new, explored_new, spaths
	end

	def self.unexplored(steps, explored)
		steps.reject { |x| explored.member? x }
	end
end


