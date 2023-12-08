#!/bin/ruby

steps = STDIN.gets.strip.split("")

STDIN.gets

nodes = {}
STDIN.each do |line|
  from, left, right = line.strip.match(/^(\w+)\s+=\s+\((\w+),\s+(\w+)\)$/).captures
  nodes[from] = { "L" => left, "R" => right}
end


results = []
nodes.keys.each do |location|
  next unless location.match(/A$/)

  step = 0
  loop do
    direction = steps[step % steps.length]
    location = nodes[location][direction]
    step = step+1
    break if location.match(/.*Z/)
  end
  results.push(step)
end
puts results.reduce(1, :lcm)
