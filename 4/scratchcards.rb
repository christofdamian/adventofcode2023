#!/bin/ruby

sum = 0
STDIN.each do |line|
  (_, winning, draw) = line.match(/^Card\s+(\d+): ([\d\s]+) \| ([\d\s]+)/).captures

  count = winning.split.intersection(draw.split).length

  sum = sum + (1 << count-1)
end
puts sum
