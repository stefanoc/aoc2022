require 'set'

def input
  File.read('../inputs/day4.txt')
end

def part1
  input.split("\n").count do |assignments|
    one, two = assignments.split(',')
    one = one.split('-')
    one = one[0].to_i..one[1].to_i
    two = two.split('-')
    two = two[0].to_i..two[1].to_i

    one.cover?(two) || two.cover?(one)
  end
end

def part2
  input.split("\n").count do |assignments|
    one, two = assignments.split(',')
    one = one.split('-')
    one = Set.new(one[0].to_i..one[1].to_i)
    two = two.split('-')
    two = Set.new(two[0].to_i..two[1].to_i)

    one.intersect?(two)
  end
end

puts part1
puts part2
