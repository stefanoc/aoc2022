def input
  File.read('../inputs/day2.txt')
end

def part1
  input.split("\n").inject(0) do |score, round|
    round = round.split.map(&:ord)
    score + case [round[0] - 65, round[1] - 88]
            in [you, me] if you == me
              3 + me + 1
            in [0, 1] | [1, 2] | [2, 0]
              6 + me + 1
            else
              me + 1
            end
  end
end

def part2
  win = ->(rsp) { (rsp + 1) % 3 }
  lose = ->(rsp) { ((rsp - 1) % 3).abs }
  input.split("\n").inject(0) do |score, round|
    you, move = *round.split.map(&:ord)
    you -= 65
    move -= 88
    score + case move
            when 0
              me = lose.call(you)
              me + 1
            when 1
              me = you
              3 + me + 1
            when 2
              me = win.call(you)
              6 + me + 1
            end
  end
end

puts part1
puts part2
