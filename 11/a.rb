require_relative 'lib/parser'

NUM_OF_ROUNDS = 20

monkeys = ARGF.slice_after(/^$/).map { |lines| Parser.parse lines }

NUM_OF_ROUNDS.times do
  monkeys.each do |monkey|
    monkey.inspect_items
    monkey.items.map! { |i| (i / 3).floor }
    monkey.throw_items { |target, i| monkeys[target].catch_item i }
  end
end

puts monkeys.map(&:inspection_count).max(2).inject(:*)
