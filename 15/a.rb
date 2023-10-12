CHECK_ROW_TEST = 10
CHECK_ROW_PROD = 2000000
CHECK_ROW = CHECK_ROW_PROD

Sensor = Struct.new(:x, :y, :coverage) do
  def cover_row?(row)
    row.between? self.y - self.coverage, self.y + self.coverage
  end
end

def rectilinear_dist(a, b)
  (a.first - b.first).abs + (a.last - b.last).abs
end

def parse_input
  ARGF.each_with_object({ sensors: [], beacons: [] }) do |line, obj|
    sensor, beacon = line.split(': ').map do |seg|
      seg.match(/x=(-?\d+), y=(-?\d+)/).captures.map(&:to_i)
    end

    obj[:sensors] << Sensor.new(*sensor, rectilinear_dist(sensor, beacon))
    obj[:beacons] << beacon
  end
end

def x_coord_covered_at_row(sensors, row)
  sensors.filter { |s| s.cover_row? row }.flat_map do |s|
    remaining_steps = s.coverage - (s.y - row).abs
    x_bounds = [s.x - remaining_steps, s.x + remaining_steps]
    Range.new(*x_bounds).to_a
  end
end

def beacons_at_row(beacons, row)
  beacons.filter_map { |b| b.first if b.last == row }.uniq
end

sensors, beacons = parse_input.values_at(:sensors, :beacons)
beacons_x = beacons_at_row(beacons, CHECK_ROW)
p x_coord_covered_at_row(sensors, CHECK_ROW).reject { beacons_x.include? _1 }.uniq.count
