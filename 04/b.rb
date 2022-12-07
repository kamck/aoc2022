def new_range(r) = Range.new(*r.split('-').map(&:to_i)).to_a

def parse(line)
  a, b = line.split(',')
  [new_range(a), new_range(b)]
end

overlaps = ARGF.filter do |x|
  elf1, elf2 = parse(x)
  elf1.intersect? elf2
end

puts overlaps.count
