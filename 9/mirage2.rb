#!/bin/ruby

sequences = []
STDIN.each do |line|
  sequences.push(line.strip.split.map(&:to_i))
end

sum = 0
sequences.each do |sequence|
  stack = []
  row = sequence
  loop do
    stack.push(row)
    break if row.all? { |a| a==0 }
    row = row.each_cons(2).to_a.map {|a| a[1]-a[0] }
  end

  for i in (0...stack.length).to_a.reverse do
     stack[i].unshift(stack[i].first-(stack[i+1]&.first || 0))
  end

  sum = sum + stack.first.first
end
puts sum
