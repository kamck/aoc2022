OPPONENT = {
  'A' => 'rock',
  'B' => 'paper',
  'C' => 'scissors',
}

ME = {
  'X' => 0,
  'Y' => 3,
  'Z' => 6,
}

PLAYTABLE = {
  rock_3: 'rock',
  rock_6: 'paper',
  rock_0: 'scissors',

  paper_0: 'rock',
  paper_3: 'paper',
  paper_6: 'scissors',

  scissors_6: 'rock',
  scissors_0: 'paper',
  scissors_3: 'scissors',
}

MODIFIER = {
  'rock' => 1,
  'paper' => 2,
  'scissors' => 3,
}

my_score = ARGF.inject(0) do |score, x|
  one, two = x.chomp.split(' ')

  them = OPPONENT[one]
  me = ME[two]

  need_to_play = PLAYTABLE["#{them}_#{me}".to_sym]
  this_round = me + MODIFIER[need_to_play]
  score += this_round
end

puts my_score
