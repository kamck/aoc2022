require_relative 'position'

class Chart
	attr_reader :start

	def initialize(data)
		@grid = data
		set_locations
	end

	def at(pos)
		@grid[pos.y][pos.x]
	end
 	
	def destination?(pos)
		@destination == pos
	end

	def available_steps(p)
		%i[up down left right].filter_map do |step|
			s = p.send(step)
			s if valid_step?(s) && within_elev?(p, s)
		end
	end

	def potential_starts
		@grid.each_with_index.map do |row, y|
			row.each_with_index.filter_map do |cell, x|
				Position.new(x, y) if cell == 'a'
			end
		end.flatten
	end

	private

		def set_locations
			@grid.each_with_index do |row, y|
				start_index = row.find_index('S') unless @start
				set_start(start_index, y) if start_index
				dest_index = row.find_index('E') unless @destination
				set_destination(dest_index, y) if dest_index
				break if @start && @destination
			end
		end

		def set_start(x, y)
			@start = Position.new(x, y)
			@grid[y][x] = 'a'
		end

		def set_destination(x, y)
			@destination = Position.new(x, y)
			@grid[y][x] = 'z'
		end

		def valid_step?(pos)
			max_x = @grid.first.size - 1
			max_y = @grid.size - 1
			pos.x.between?(0, max_x) && pos.y.between?(0, max_y)
		end

		def within_elev?(current, pos)
			at(pos).ord - at(current).ord <= 1
		end
end
