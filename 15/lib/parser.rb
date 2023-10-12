require_relative 'sensor'

class Parser
  def self.parse_input
    ARGF.each_with_object({ sensors: [], beacons: [] }) do |line, obj|
      sensor, beacon = line.split(': ').map do |seg|
        seg.match(/x=(-?\d+), y=(-?\d+)/).captures.map(&:to_i)
      end

      obj[:sensors] << Sensor.new(*sensor, beacon)
      obj[:beacons] << beacon
    end
  end
end
