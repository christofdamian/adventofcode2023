#!/bin/ruby



def adjacent(data, y, x)
  found = []
  [-1, 0, 1].each do |y_offset|
    [-1, 0, 1].each do |x_offset|
      next if y_offset==0 and x_offset==0
      next if data[y+y_offset].nil?
      char = data[y+y_offset][x+x_offset]
      next if char.nil?
      if char == '*'
        found.push([y+y_offset, x+x_offset])
      end
    end
  end
  return found
end


data = []

STDIN.each do |line|
  data.push(line.split(""))
  puts line
end

number = ""
found = []
stars = []
data.each_with_index do |line, y|
  line.each_with_index do |char, x|
    if char.match(/\d/)
      number = number + char
      found = found + adjacent(data, y, x)
    else
      if number != ""
        found.each do |row|
          stars[row[0]] ||= []
          stars[row[0]][row[1]] ||= []
          stars[row[0]][row[1]].push(number)
        end
      end
      number = ""
      found = []
    end
  end
end

sum = 0
stars.each do |row|
  next if row.nil?
  row.each do |found|
    next if found.nil?
    found.uniq!
    if found.length == 2
      puts found.inspect
      sum = sum + found[0].to_i*found[1].to_i
    end
  end
end

puts sum
