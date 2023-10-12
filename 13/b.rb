require 'json'
require_relative 'lib/packet'

DIVIDER1 = [[2]]
DIVIDER2 = [[6]]

list = ARGF.reject { |x| x.chomp.empty? }
  .map { |x| Packet.new(JSON.parse(x)) }
  .push(DIVIDER1, DIVIDER2)
  .sort

p (list.index(DIVIDER1) + 1) * (list.index(DIVIDER2) + 1)
