SMALL_MAP = [6, 4]
LARGE_MAP = [26, 20]

Mapper = Struct.new(:max_x, :max_y) do
  def map(points)
    max_y.downto(0) do |y|
      for x in 0...max_x do
        _, i = find_top(points, x, y)
        print name(i)
      end

      puts
    end

    puts
  end

  def find_top(points, x, y)
    points.each_with_index
          .filter { |pt, i| pt.values == [x, y] }
          .first
  end

  def name(i)
    case i
    when 0 then 'H'
    when nil then '.'
    else i
    end
  end
end

