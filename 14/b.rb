require_relative 'lib/grid'
require_relative 'lib/position'

SAND_START= Position.new(500, 0)

def expand_line(a, b)
  if a.x == b.x
    Range.new(*[a, b].map(&:y).sort).map { |y| Position.new(a.x, y) }
  else
    Range.new(*[a, b].map(&:x).sort).map { |x| Position.new(x, a.y) }
  end
end

def parse_input
  ARGF.map do |line|
    line.chomp.split(/\s->\s/).each_cons(2).map do |start, dest|
      expand_line Position.new(start), Position.new(dest)
    end
  end
end

def drop_sand(grid, start)
  new_pos = start

  while new_pos.y < grid.depth + 1 do
    next_move = new_pos.next_moves.find { |s| !grid[s.x, s.y] }
    if !next_move
      break
    else
      new_pos = next_move
    end
  end 

  new_pos
end

grid = Grid.new(parse_input.flatten)

loop.each_with_index do |_, i|
  sand = drop_sand grid, SAND_START
  grid[sand.x, sand.y] = 'o'
  break if sand == SAND_START
end

puts grid.grid.sum { |row| row.count { |c| c == 'o' } }
