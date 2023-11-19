require 'nokogiri'
require 'open-uri'

input = Nokogiri::HTML5(URI.open("input.html")).text

input = input.split("\n")

# A = rock = 1
# B = paper = 2
# C = scissors = 3

# input = ["A Y", "B X", "C Z"]
score = 0

def result_score(outcome)
  case outcome
    when "X"
      0
    when "Y"
      3
    when "Z"
      6
  end
end

def shape_score(opponent_shape, outcome)
  if outcome == "X"
    case opponent_shape
      when "A"
        3
      when "B"
        1
      when "C"
        2
    end
  elsif outcome == "Y"
    case opponent_shape
      when "A"
        1
      when "B"
        2
      when "C"
        3
    end
  else
    case opponent_shape
      when "A"
        2
      when "B"
        3
      when "C"
        1
    end
  end
end

def score_game(pair)
  score = 0
  outcome = pair[1]
  opponent_shape = pair[0]
  result = result_score(outcome)
  shape = shape_score(opponent_shape, outcome)
  return result + shape
end

input.each do |pair|
  pair = pair.split(" ")
  score += score_game(pair)
end

puts "score for part two is #{score}"
