require_relative 'border'

class Sensor
  def initialize(x, y, beacon)
    @x = x
    @y = y
    @coverage = rectilinear_dist(beacon)
  end

  def borders
    [
      ->(c) { [@x - c, @y + (@coverage - c)] },
      ->(c) { [@x - (@coverage - c), @y - c] },
      ->(c) { [@x + c, @y - (@coverage - c)] },
      ->(c) { [@x + (@coverage - c), @y + c] },
    ].map { |p| (0...@coverage).map { |i| p.call(i) } }
  end

  def margins(d = 1)
    coverage_n = @coverage + d
    [
      Border.new([@x - coverage_n, @y], [@x, @y - coverage_n]),
      Border.new([@x, @y - coverage_n], [@x + coverage_n, @y]),
      Border.new([@x + coverage_n, @y], [@x, @y + coverage_n]),
      Border.new([@x, @y + coverage_n], [@x - coverage_n, @y]),
    ]
  end

  def overlap(other)
    other_margins = other.margins

    margins.map do |my_margin|
      other_margins.map do |oth|
        my_margin.overlap(oth).size
      end
    end
  end

  private

    def rectilinear_dist(beacon)
      (@x - beacon.first).abs + (@y - beacon.last).abs
    end
end
