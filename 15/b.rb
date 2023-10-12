require_relative 'lib/ranger'

MAX_COORDINATE_TEST = 20
MAX_COORDINATE_PROD = 4000000
MAX_COORDINATE = MAX_COORDINATE_PROD

MULTIPLIER = 4000000

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
  sensors.filter { |s| s.cover_row? row }.map do |s|
    remaining_steps = s.coverage - (s.y - row).abs
    [
      (s.x - remaining_steps).clamp(0, MAX_COORDINATE),
      (s.x + remaining_steps).clamp(0, MAX_COORDINATE),
    ]
  end
end

def beacons_at_row(beacons, row)
  beacons.filter_map { |b| b.first if b.last == row }.uniq
end

def y_bounds(sensors)
  min_y = sensors.sort_by { |s| s.y - s.coverage }.map(&:y).min
  max_y = sensors.sort_by { |s| s.y + s.coverage }.map(&:y).max
  [min_y, max_y]
end

def connected?(a, b)
  a.last >= b.first - 1
end

sensors, beacons = parse_input.values_at(:sensors, :beacons)

min_y, max_y = y_bounds(sensors)
possible_x = (0..MAX_COORDINATE).to_a

(min_y..max_y).each do |y|
  ranger = Ranger.new(x_coord_covered_at_row(sensors, y))

  if y >= 33566
    puts "Row #{y} #{ranger.gaps}"
  end

  unless ranger.gaps.empty?
    binding.break
    puts "Not covered at row #{y}"
    exit
  end
end
