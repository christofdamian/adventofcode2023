#!/bin/ruby

steps = STDIN.gets.strip.split("")

STDIN.gets

nodes = {}
STDIN.each do |line|
  from, left, right = line.strip.match(/^(\w+)\s+=\s+\((\w+),\s+(\w+)\)$/).captures
  nodes[from] = { "L" => left, "R" => right}
end

locations = []
nodes.keys.each do |key|
  locations.push(key) if key.match(/A$/)
end

step = 0
loop do
  direction = steps[step % steps.length]

  locations = locations.map do |location|
    nodes[location][direction]
  end

  step = step+1
  break if locations.all? { |l| l.match(/.*Z/) }
end

puts step
