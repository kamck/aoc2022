def include_current_tree?(count, ary)
  if count == ary.size
    count
  else
    count + 1
  end
end

def count_steps(value, ary)
  cnt = ary.take_while { |x| x < value }.count
  include_current_tree? cnt, ary
end

def scenic_score(ary, i)
  value = ary[i]
  left = count_steps(value, ary.take(i).reverse)
  right = count_steps(value, ary.drop(i + 1))
  left * right
end

def calc(list_of_scores)
  list_of_scores.flatten.max
end

def strip_edges(e)
  e.each_with_index.filter_map do |element, i|
    [element, i] if i.between? 1, e.size - 2
  end
end

grid = ARGF.collect { |x| x.chomp.chars.collect(&:to_i) }

ct = strip_edges(grid).collect do |row, i|
  strip_edges(row).collect do |cell, j|
    col = grid.collect { |x| x[j] }
    scenic_score(row, j) * scenic_score(col, i)
  end
end

puts calc(ct)

