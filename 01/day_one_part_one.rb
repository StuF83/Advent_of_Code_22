require 'nokogiri'
require 'open-uri'

input = Nokogiri::HTML5(URI.open("input.html")).text

elf_cal_list = []
input.split("\n\n").each { |sub_list| elf_cal_list << sub_list.split("\n")}

elf_cal_list.each do |string_list|
  string_list.map! do |strings|
    strings.to_i
  end
end

elf_number = 0
calories = 0
elf_cal_list.each_with_index do |cals, elf|
  (calories = cals.sum) && (elf_number = (elf += 1)) if cals.sum > calories
end

puts "Elf Number #{elf_number} is carrying the most calories with #{calories}."

elf_cals = {}
elf_cal_list.each_with_index do |cals, elf|
  elf += 1
  elf_cals[elf] = cals.sum
end

efl_cals_sorted = elf_cals.sort_by { |key, value| value}
top_three =  efl_cals_sorted.last(3)

total = 0
top_three.each do |elf|
  total += elf[1]
end

puts "Top Three Elves combined calories #{total}."
