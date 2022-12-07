require 'pathname'

TOTAL_SPACE = 70000000
REQUIRED_SPACE = 30000000
ROOT = Pathname.new('/')

cwd = ROOT
tree = {}

ARGF.slice_before { |i| i =~ /\$ cd/ }.each do |tuple|
  dir = tuple.shift.chomp[5..]

  if dir == '..'
    tree[cwd.parent] += tree[cwd]
    cwd = cwd.parent
    next
  end

  cwd = cwd / dir
  tree[cwd] = tuple.sum { |x| x.split(/\s/).first.to_i }
  tree[ROOT] += tree[cwd] if ARGF.closed?
end

puts tree.values
         .filter { |v| v >= REQUIRED_SPACE - (TOTAL_SPACE - tree[ROOT]) }
         .min
