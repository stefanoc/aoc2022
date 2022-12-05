def input
  @input ||= File.read('../inputs/day5.txt')
end

def stacks
  @stacks ||=
    begin
      rows = input.split("\n\n")[0].split("\n")
      num = rows[-1].split.size
      res = Array.new(num) { [] }
      rows[0...-1].reverse.each do |row|
        crates = "#{row} ".scan(/((\[(\w)\])|\s{3}) /)
        (0...num).each do |col|
          crate = crates[col][2]
          res[col] << crate if crate
        end
      end
      res
    end
end

def moves
  input.split("\n\n")[1].split("\n")
end

def part1
  pat = /move (\d+) from (\d+) to (\d+)/
  moves.each do |line|
    move = pat.match(line)
    move[1].to_i.times do
      stacks[move[3].to_i - 1].push(stacks[move[2].to_i - 1].pop)
    end
  end
  stacks.map(&:last).join
end

puts part1
