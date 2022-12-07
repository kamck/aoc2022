LOWERCASE = 96
UPPERCASE = 38

badges = ARGF.each_slice(3).sum do |tuple|
  arys = tuple.map { |x| x.chomp.chars }
  i = (arys.first & arys[1] & arys.last).first
  i.ord - (i =~ /[[:lower:]]/ ? LOWERCASE : UPPERCASE)
end

puts badges
