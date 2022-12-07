LOWERCASE = 96
UPPERCASE = 38

priorities = ARGF.sum do |line|
  split_at = line.chomp.length / 2
  comp1 = line[0, split_at].chars
  comp2 = line[split_at..].chars
  i = comp1.intersection(comp2).first
  i.ord - (i =~ /[[:lower:]]/ ? LOWERCASE : UPPERCASE)
end

puts priorities
