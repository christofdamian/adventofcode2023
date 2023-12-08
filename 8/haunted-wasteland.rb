#!/bin/ruby

steps = STDIN.gets.strip.split("")

STDIN.gets

nodes = {}
STDIN.each do |line|
  from, left, right = line.strip.match(/^(\w+)\s+=\s+\((\w+),\s+(\w+)\)$/).captures
  nodes[from] = { "L" => left, "R" => right}
end

step = 0
location = "AAA"

loop do
  direction = steps[step % steps.length]
  location = nodes[location][direction]
  step = step+1
  break if location == "ZZZ"
end

puts step
