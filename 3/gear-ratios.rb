#!/bin/ruby




def is_adjacent(data, y, x)
  [-1, 0, 1].each do |y_offset|
    [-1, 0, 1].each do |x_offset|
      next if y_offset==0 and x_offset==0
      next if data[y+y_offset].nil?
      char = data[y+y_offset][x+x_offset]
      next if char.nil?
      next if char == '.'
      next if char == "\n"
      next if char.match(/\d/)
      return true
    end
  end
  return false
end


data = []

STDIN.each do |line|
  data.push(line.split(""))
  puts line
end

sum = 0
number = ""
adjacent = false
data.each_with_index do |line, y|
  line.each_with_index do |char, x|
    if char.match(/\d/)
      number = number + char
      adjacent = adjacent || is_adjacent(data, y, x)
    else
      if number != ""
        puts number
        if adjacent
          sum = sum + number.to_i
        end
      end
      number = ""
      adjacent = false
    end
  end
end

puts sum
