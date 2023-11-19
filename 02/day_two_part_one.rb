require 'nokogiri'
require 'open-uri'

input = Nokogiri::HTML5(URI.open("input.html")).text

input = input.split("\n")
# input = ["A Y", "B X", "C Z"]
score = 0

def shape_score(shape, score)
  case shape
  when "X"
    1
  when "Y"
    2
  when "Z"
    3
  end
end

def result_score(pair, score)
  if ((pair[0] == "A" && pair[1] == "X") || (pair[0] == "B" && pair[1] == "Y") || (pair[0] == "C" && pair[1] == "Z"))
    3
  elsif ((pair[0] == "A" && pair[1] == "Y") || (pair[0] == "B" && pair[1] == "Z") || (pair[0] == "C" && pair[1] == "X"))
    6
  else
    return score
  end
end

def score_game(pair)
  score = 0
  shape = pair[1]
  shape_score = shape_score(shape, score)
  result_score = result_score(pair, score)
  return shape_score + result_score
end

input.each do |pair|
  pair = pair.split(" ")
  score += score_game(pair)
end

puts "score for part one is #{score}"
