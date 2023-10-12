require_relative 'lib/parser'
require_relative 'lib/sensor'

sensors = Parser.parse_input[:sensors]

sensors.each_with_index do |sensor, i|
  puts "Checking sensor #{i}"

  field = sensors[(i + 1)..]

  binding.break

  field.each do |f|
    if sensor.overlap? f
      puts "found an intersection #{sensor}"
      p sensor.overlap(f)
      exit
    end
  end
end

