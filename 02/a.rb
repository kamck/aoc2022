OPPONENT = {
  'A' => 'rock',
  'B' => 'paper',
  'C' => 'scissors',
}

ME = {
  'X' => 'rock',
  'Y' => 'paper',
  'Z' => 'scissors',
}

PLAYTABLE = {
  rock_rock: 3,
  rock_paper: 6,
  rock_scissors: 0,

  paper_rock: 0,
  paper_paper: 3,
  paper_scissors: 6,

  scissors_rock: 6,
  scissors_paper: 0,
  scissors_scissors: 3,
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

  this_round = PLAYTABLE["#{them}_#{me}".to_sym] + MODIFIER[me]
  score += this_round
end

puts my_score
