def tallest?(ary, i)
  value = ary[i]
  value > ary.take(i).max || value > ary.drop(i + 1).max
end

def calc(ct, grid)
  rows = grid.size * 2
  cols = (grid.first.size - 2) * 2
  ct.compact.sum + rows + cols
end

def strip_edges(e)
  e.each_with_index.filter_map do |element, i|
    [element, i] if i.between? 1, e.size - 2
  end
end

grid = ARGF.collect { |x| x.chomp.chars.collect(&:to_i) }

ct = strip_edges(grid).collect do |row, i|
  strip_edges(row).count do |cell, j|
    col = grid.collect { |x| x[j] }
    tallest?(row, j) || tallest?(col, i)
  end
end

puts calc(ct, grid)

