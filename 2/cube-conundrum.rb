#!/bin/ruby

LIMITS = {
  "red" => 12,
  "green" => 13,
  "blue" => 14,
}


sum_valid = 0
sum_power = 0
STDIN.each do |line|
  game, cubes = line.match(/^Game (\d+): (.*)$/).captures
  puts game
  valid = true
  maximum = {
    "red" => 0,
    "green" => 0,
    "blue" => 0,
  }
  cubes.split(/;/).each do |grab|
    grab.strip.split(/,/).each do |throw|
      count, colour = throw.strip.split(/ /)

      if count.to_i > LIMITS[colour]
        valid = false
      end

      if count.to_i > maximum[colour]
        maximum[colour] = count.to_i
      end
    end
  end
  power = maximum["red"]*maximum["green"]*maximum["blue"]
  sum_power = sum_power + power
  if valid
    sum_valid = sum_valid + game.to_i
  end
end
puts sum_valid
puts sum_power
