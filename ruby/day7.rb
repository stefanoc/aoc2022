require 'pp'
require 'debug'

def input
  @input ||= File.read('../inputs/day7.txt')
end

class FS
  attr_reader :dirs, :files

  def initialize
    @path = []
    @dirs = {}
    @files = []
  end

  def parse(input)
    input.split("\n").each do |line|
      cmd = CMD.match(line)
      if cmd
        cd(cmd[:arg].strip) if cmd[:cmd] == 'cd'
      else
        size, name = line.split
        file(name, size.to_i) unless size == 'dir'
      end
    end
  end

  def cd(arg)
    case arg
    when '..'
      @path.pop
    when '/'
      @path = []
    else
      @path.push(arg)
    end
    @dirs["/#{@path.join('/')}"] = true
  end

  def file(name, size)
    dir = "/#{@path.join('/')}"
    @files << { name:, size:, dir: }
    @dirs[dir] = true
  end

  def dirsize(dir)
    total = 0
    @files.each do |file|
      next unless file[:dir].start_with?(dir)

      total += file[:size]
    end
    total
  end
end

CMD = /^\$ (?<cmd>cd|ls)(?<arg>.*)/

def part1
  fs = FS.new
  fs.parse(input)
  total = 0
  fs.dirs.each_key do |dir|
    next if dir == '/'

    size = fs.dirsize(dir)
    total += size if size <= 100_000
  end
  total
end

def part2
  fs = FS.new
  fs.parse(input)

  used_space = fs.dirsize('/')
  free_space = 70_000_000 - used_space
  needed = 30_000_000 - free_space
  dirs = fs.dirs.keys.map do |d|
    size = fs.dirsize(d)
    [d, fs.dirsize(d)] if size >= needed
  end

  pp dirs.compact
  dirs.compact.min_by { |(_, size)| size }[1]
end

puts part1
puts part2
