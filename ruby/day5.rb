def input
  @input ||= File.read('../inputs/day5.txt')
end

def get_stacks
  rows = input.split("\n\n")[0].split("\n")
  num = rows[-1].split.size
  res = Array.new(num) { [] }
  pat = /\[(.)\]/
  rows[0...-1].reverse.each do |row|
    num.times do |n|
      crate = row[(n * 4)...(n * 4) + 4]
      res[n] << Regexp.last_match[1] if crate =~ pat
    end
  end
  res
end

def moves
  input.split("\n\n")[1].split("\n")
end

def part1
  pat = /move (\d+) from (\d+) to (\d+)/
  stacks = get_stacks
  moves.each do |line|
    move = pat.match(line)
    move[1].to_i.times do
      stacks[move[3].to_i - 1].push(stacks[move[2].to_i - 1].pop)
    end
  end
  stacks.map(&:last).join
end

def part2
  pat = /move (\d+) from (\d+) to (\d+)/
  stacks = get_stacks
  moves.each do |line|
    move = pat.match(line)
    qty = move[1].to_i
    src = move[2].to_i - 1
    dst = move[3].to_i - 1
    stacks[dst].concat(stacks[src].pop(qty))
  end
  stacks.map(&:last).join
end

puts part1
puts part2
