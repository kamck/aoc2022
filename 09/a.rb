KNOT_COUNT = 2
START = [0, 0]

Point = Struct.new(:x, :y) do
  def move(direction)
    case direction
    when 'R' then self.x += 1
    when 'L' then self.x += -1
    when 'U' then self.y += 1
    when 'D' then self.y += -1
    end
  end

  def follow(leader)
    self.x += leader.x <=> self.x
    self.y += leader.y <=> self.y
  end

  def adjacent?(oth_point)
    x_diff = self.x - oth_point.x
    y_diff = self.y - oth_point.y
    x_diff.abs <= 1 && y_diff.abs <= 1
  end
end

def move_rope(knots, direction)
  knots.first.move(direction)

  knots.each_cons(2) do |leader, follower|
    follower.follow leader unless leader.adjacent? follower
  end

  knots.last.values
end

knots = Array.new(KNOT_COUNT) { Point.new(*START) }

visits = ARGF.map(&:split).map do |direction, steps|
  steps.to_i.times.map do
    move_rope knots, direction
  end
end

puts visits.flatten(1).uniq.count
