def input
  @input ||= File.read('../inputs/day8.txt')
end

class Map
  def initialize
    @trees = []
    @width = nil
    @height = 0
  end

  def parse(input)
    input.split("\n").each do |line|
      treeline = line.chars.map(&:to_i)
      @height += 1
      @width ||= treeline.size
      @trees.concat(treeline)
    end
  end

  def visible?(x, y)
    tree = @trees[(y * @width) + x]
    return true if x.zero? || x == @width - 1 || y.zero? || y == @height - 1

    left = (0..x - 1).all? { |tx| @trees[(y * @width) + tx] < tree }
    right = (x + 1...@width).all? { |tx| @trees[(y * @width) + tx] < tree }
    top = (0..y - 1).all? { |ty| @trees[(ty * @width) + x] < tree }
    bottom = (y + 1...@height).all? { |ty| @trees[(ty * @width) + x] < tree }

    left || right || top || bottom
  end

  def count_visible
    count = 0
    (0...@height).each do |y|
      (0...@width).each do |x|
        count += 1 if visible?(x, y)
      end
    end
    count
  end

  def visibility(x, y)
    tree = @trees[(y * @width) + x]

    left = 0
    (0..x - 1).to_a.reverse.each do |tx|
      other = @trees[(y * @width) + tx]
      left += 1
      break if other >= tree
    end
    right = 0
    (x + 1...@width).each do |tx|
      other = @trees[(y * @width) + tx]
      right += 1
      break if other >= tree
    end
    top = 0
    (0..y - 1).to_a.reverse.each do |ty|
      other = @trees[(ty * @width) + x]
      top += 1
      break if other >= tree
    end
    bottom = 0
    (y + 1...@height).each do |ty|
      other = @trees[(ty * @width) + x]
      bottom += 1
      break if other >= tree
    end
    left * right * top * bottom
  end

  def max_visibility
    max = 0
    (0...@height).each do |y|
      (0...@width).each do |x|
        vis = visibility(x, y)
        max = vis if vis > max
      end
    end
    max
  end
end

def part1
  map = Map.new
  map.parse(input)
  map.count_visible
end

def part2
  map = Map.new
  map.parse(input)
  map.max_visibility
end

puts part1
puts part2
