MARKER_SIZE = 14

ARGF.each do |line|
  line.chars.each_cons(MARKER_SIZE) do |x|
    if x.uniq.size == MARKER_SIZE
      puts line.index(x.join) + MARKER_SIZE
      break
    end
  end
end
