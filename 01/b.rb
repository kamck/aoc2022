data = ARGF.slice_after(/^\n/).map do |tuple|
  tuple.reject { |x| x.chomp.empty? }.map(&:to_i).sum
end

puts data.sort.reverse.first(3).sum
