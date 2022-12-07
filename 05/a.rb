def build_stacks(tuple, stacks)
  tuple.each do |line|
    stacks.size.times.each_with_index do |i|
      n = i * 4 + 1
      stacks[i] << line[n] unless line[n].strip.empty?
    end
  end
end

def process_stacks(tuple, stacks)
  tuple.pop
  tuple.pop.split(/\s+/).last.to_i.times { stacks << Array.new }
  build_stacks(tuple, stacks)
  stacks.map(&:reverse!)
end

def process_instructions(tuple, stacks)
  tuple.each do |line|
    qty, src, dest = line.match(/move (\d+) from (\d+) to (\d+)/).captures.map(&:to_i)

    qty.times do
      stacks[dest - 1] << stacks[src - 1].pop
    end
  end
end

stacks = ARGF.slice_after(/^\s*$/).each_with_object([]) do |tuple, stacks|
  if stacks.empty?
    process_stacks(tuple, stacks)
  else
    process_instructions(tuple, stacks)
  end
end

puts stacks.map(&:pop).join
