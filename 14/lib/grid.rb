class Grid
  attr_reader :grid, :x_diff
  attr_accessor :depth

  def initialize(data)
    bounds_x = data.map(&:x).minmax
    bounds_y = data.map(&:y).minmax
    @depth = bounds_y.last

    @grid = Array.new(@depth) do
      Array.new(bounds_x.last)
    end

    data.each { |pos| self[pos.x, pos.y] = '#' }
  end

  def [](x, y)
    @grid&.at(y)&.at(x)
  end

  def []=(x, y, val)
    row = @grid[y] ||= Array.new
    row[x] = val
  end
end
