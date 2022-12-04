require 'set'

def input
  File.read('../inputs/day3.txt')
end

def part1
  priority = ->(item) { (item.ord - 96).negative? ? item.ord - 38 : item.ord - 96 }
  input.split("\n").inject(0) do |total, items|
    left = items[0...items.size / 2].chars
    right = items[items.size / 2..].chars
    common = Set.new(left).intersection(Set.new(right)).to_a[0]
    total + priority.call(common)
  end
end

def part2
  priority = ->(item) { (item.ord - 96).negative? ? item.ord - 38 : item.ord - 96 }
  input.split("\n").each_slice(3).inject(0) do |total, group|
    group = group.map { |g| Set.new(g.chars) }
    common = group[0].intersection(group[1]).intersection(group[2]).to_a[0]
    total + priority.call(common)
  end
end

puts part1
puts part2
