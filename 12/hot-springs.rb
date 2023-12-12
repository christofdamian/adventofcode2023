#!/bin/ruby

def brute(springs, position=0)
  if position==springs.length then
    return [springs]
  end

  if springs[position]=='?'
    results = []
    springs[position] = '.'
    results += brute(springs.clone, position+1)
    springs[position] = '#'
    results += brute(springs.clone, position+1)
    return results
  else
    return brute(springs, position+1)
  end
end

count = 0
STDIN.each do |line|
  springs, g = line.strip.split
  groups = g.split(',').map(&:to_i)

  brute(springs).each do |candidate|
    if candidate.split(".").reject(&:empty?).map(&:length)==groups then
      count = count+1
    end
  end
end
puts count
