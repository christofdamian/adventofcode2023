#!/bin/ruby

valleys = []

valley = []
STDIN.each do |line|
  line = line.strip
  if line.empty?
    valleys.push(valley)
    valley = []
    next
  end
  valley.push(line.split(""))
end
valleys.push(valley)

def parse_valley(valley)
  found_splits = {}

  valley.each do |row|
    found = nil
    for split in 1...(row.length) do
      left = row.slice(0, split)
      right = row.slice(split, row.length)
      length = [left.length,right.length].min

      left = left.last(length)
      right = right.first(length)

      if left == right.reverse
         found = split
         found_splits[found] ||=0
         found_splits[found] +=1
      end
    end
  end
  found_splits
    .filter { |k,v| v==valley.length }
    .keys
    .sort { |s| (s-valley[0].length/2).abs }
    .first
end


sum = 0
valleys.each do |valley|
  sum += parse_valley(valley) || 0
  sum += (parse_valley(valley.transpose) || 0)*100
end
puts sum
