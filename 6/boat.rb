#!/bin/ruby

def read_row
  STDIN.gets.match(/^.+:\s+([\d\s]+)/).captures.pop.split.map { |x| x.to_i }
end

def race(winning_time, winning_distance)
  won = 0
  for wait in 0..winning_time do
    speed = wait
    remaining_time = winning_time-wait
    distance = remaining_time*speed

    if distance > winning_distance
      won = won+1
    end
  end
  return won
end

def race_all(times, distances)
  result = 1
  times.zip(distances).each do |time, distance|
    result = result * race(time, distance)
  end
  result
end

times = read_row
distances = read_row

puts "Part One"
puts race_all(times, distances)

puts "Part Two"
puts race(times.join.to_i, distances.join.to_i)
