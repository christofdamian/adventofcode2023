#!/bin/ruby

def read_block
  lines = []
  STDIN.each do |line|
    line.strip!
    break if line.empty?
    lines.push(line)
  end
  lines
end

def read_blocks
  maps = {}
  while lines = read_block()
    break if lines.empty?
    first_line = lines.shift
    if m = first_line.match(/^seeds:\s+([\d\s]+)\s*$/)
      seeds = m[1].split.map { |i| i.to_i }
    elsif m = first_line.match(/^(\w+)-to-(\w+)\s+map:\s*$/)
      map = {
        source: m[1],
        destination: m[2],
        ranges: [],
      }
      lines.each do |line|
        range = line.split
        map[:ranges].push(
          {
            destination_start: range[0].to_i,
            source_start: range[1].to_i,
            range_length: range[2].to_i,
          }
        )
      end
      maps[map[:source]] = map
    end
  end
  [seeds, maps]
end

def find_destination(maps, source, number, length)
  map = maps[source]
  map[:ranges].each do |range|
    if number>=range[:source_start] and
      number<range[:source_start]+range[:range_length]
      number = range[:destination_start]+number-range[:source_start]
      break
    end
  end
  return number if map[:destination] == "location"
  find_destination(maps, map[:destination], number, 1)
end



# main

seeds, maps = read_blocks()

puts "part 1"

numbers = []
seeds.each do |seed|
  numbers.push(find_destination(maps, "seed", seed, 1))
end
puts numbers.min()

puts "part 2"
puts "this is stupid, brute force, and takes half a day"

numbers = []
seeds.each_slice(2) do |number, range|
  for i in number...(number+range) do
     numbers.push(find_destination(maps, "seed", i, 1))
  end
end
puts numbers.min()
