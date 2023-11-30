require 'nokogiri'
require 'open-uri'
require_relative 'day_three_part_one'



input = Nokogiri::HTML5(URI.open("input.html")).text
sacks = input.split("\n")

# we need to create an array of arrays, each inner array is made of three elements which correspond to the
# three bags for the corresponding group elves
# once we have our array of arrays, we can run an each method on each inner array to determin which item appears
# in all three bags

# test data

# sacks = ["vJrwpWtwJgWrhcsFMMfFFhFp",
# "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL",
# "PmmdzqPrVvPwwTWBwg",
# "wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn",
# "ttgJtRGJQctTZtZT",
# "CrZsJsPPZsGzwwsLwLmpwMDw"
# ]

# we can use each_slice to take our input array, slice it into sections of 3, and push them into a new array.

def group_sacks_into_teams(sacks)
  sacks_grouped_by_team = []
  sacks.each_slice(3) { |elements| sacks_grouped_by_team.push(elements)}
  sacks_grouped_by_team
end

# we need to find the common item in each of the three bags.
# we have an array of three items
# we can take the first two arrays, find the common elements and put them into a new array
# with the new array, we can compare the third and find the common elements - there should only be one, the badge

def common_items(team_sacks_grouped)
  badge_array = []
  team_sacks_grouped.each do | team_sacks |
    common_items = []
    team_sacks[0].split("").each do | item |
      common_items.push(item) if team_sacks[1].split("").include?(item)
    end
    badge = []
    common_items.each do | item |
      badge.push(item) if team_sacks[2].split("").include?(item)
    end
    badge_array.push(badge[0])
  end
  badge_array
end


def find_team_badges(sacks)
  team_sacks_grouped = group_sacks_into_teams(sacks)
  badges = common_items(team_sacks_grouped)
  badge_score_array = []
  badges.each { |badge| badge_score_array << priority_score(badge, $item_priority)}
  badge_score_array.sum
end

puts "The sum of the badges priorities is #{find_team_badges(sacks)}"
