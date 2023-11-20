require 'nokogiri'
require 'open-uri'

input = Nokogiri::HTML5(URI.open("input.html")).text
input = input.split("\n")

# test_input = "vJrwpWtwJgWrhcsFMMfFFhFp
# jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
# PmmdzqPrVvPwwTWBwg
# wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
# ttgJtRGJQctTZtZT
# CrZsJsPPZsGzwwsLwLmpwMDw"
# test_input = test_input.split("\n")

priority_hash = {}
priority_values = Range.new(1, 52).to_a
priority_keys = Range.new("a", "z").to_a.concat(Range.new("A", "Z").to_a)
item_priority = Hash[priority_keys.zip(priority_values)]
priority_score_array = []

# we need the length of each string to give us the split between each compartment.
# we then need to compare each compartment to find the duplicate item
# we can map this item to a new array
# with this new array, we can sum the priorities of the items
# we can create a hash of priorities using ranges a..z, 1..26 and for UPPERCASE
# with the hash, we can run an each loop on the array of letters using them as a key
# mapping the value to a new array, and summing that array.

def seperate_items_into_compartmets(content_string)
  item_count_in_sack = content_string.length
  sack = []
  sack << first_compartment = content_string.slice(0, item_count_in_sack/2)
  sack << second_compartment = content_string.slice(item_count_in_sack/2, item_count_in_sack/2)
  sack
end

def find_duplicate_item(sack)
  first_compartment = sack[0].split("")
  second_compartment = sack[1].split("")
  duplicates = []
  first_compartment.each do | item_f |
    duplicates << item_f if second_compartment.include?(item_f)
  end
  duplicates.first
end

def priority_score(item, score_hash)
  score_hash[item]
end

input.each do | input |
  sack = seperate_items_into_compartmets(input)
  duplicate = find_duplicate_item(sack)
  priority_score_array << priority_score(duplicate, item_priority)
end

puts "The sum of the item priorities is #{priority_score_array.sum}"
