require 'json'
require_relative 'lib/packet'

sum = ARGF.slice_after(/^$/).each_with_index.sum do |lines, i|
  left = Packet.new(JSON.parse(lines.shift))
  right = Packet.new(JSON.parse(lines.shift))

  left < right ? i + 1 : 0
end

p sum
