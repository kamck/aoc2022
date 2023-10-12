class Border
  def initialize(start, _end)
    @start = start
    @end = _end
  end

  def line
    a, b = sort_points

    x_oper = b.first > a.first ? :+ : :-
    y_oper = b.last > a.last ? :+ : :-

    (b.first - a.first + 1).times.map do |i|
      [a.first.send(x_oper, i), a.last.send(y_oper, i)]
    end
  end

  def overlap(other_border)
    line & other_border.line
  end

  private

    def sort_points
      [@start, @end].sort do |a, b|
        r = a.first <=> b.first
        r.zero? ? a.last <=> b.last : r
      end
    end
end
