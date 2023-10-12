class Position
  attr_reader :x, :y

  def initialize(*args)
    @x, @y =
      if args.size == 1
        args.shift.split(',').map(&:to_i)
      else
        2.times.map { args.shift.to_i }
      end
  end

  def next_moves
    [@x, @x - 1, @x + 1].map do |new_x|
      Position.new(new_x, self.y + 1)
    end
  end

  def ==(other_pos)
    [@x, @y] == [other_pos.x, other_pos.y]
  end
end
