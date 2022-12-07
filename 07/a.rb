require 'pathname'

MAX_SIZE = 100000
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

puts tree.values.filter { |v| v <= MAX_SIZE}.sum
