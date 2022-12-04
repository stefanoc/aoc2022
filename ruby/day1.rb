def input
  File.read('../inputs/day1.txt')
end

def part1
  calories = input.split("\n\n").map { |foods| foods.split("\n").map(&:to_i).sum }
  calories.max
end

def part2
  calories = input.split("\n\n").map { |foods| foods.split("\n").map(&:to_i).sum }.sort.reverse
  calories[0..2].sum
end

puts part1
puts part2
