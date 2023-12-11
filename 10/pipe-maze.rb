#!/bin/ruby

def key(y, x)
  "#{y}-#{x}"
end

def connections(c, y, x)
end

def links(maze)
  start = nil
  links = {}
  maze.each_with_index do |row, y|
    row.each_with_index do |c, x|
      from = key(y, x)
      if c=='S' then
        start = from
        next
      end

      to = case c
      when '|'
        [key(y-1, x), key(y+1, x)]
      when '-'
        [key(y, x-1), key(y, x+1)]
      when 'L'
        [key(y-1, x), key(y, x+1)]
      when 'J'
        [key(y, x-1), key(y-1, x)]
      when '7'
        [key(y+1, x), key(y, x-1)]
      when 'F'
        [key(y, x+1), key(y+1, x)]
      else
        next
      end

      links[from] = to
    end
  end

  return [start, links]
end

def print_maze(maze)
  maze.each do |row|
    row.each do |field|
      print field
    end
    puts
  end
end

######################################

maze = []
pipe = []
STDIN.each_with_index do |row, y|
  row.strip.split("").each_with_index do |c, x|
    maze[y] ||= []
    maze[y][x] = c
    pipe[y] ||= []
    pipe[y][x] = '.'
  end
end

start, links = links(maze)

links[start] = links.select { |k,v| v.include?(start) }.keys

last_position = nil
position = start
length = 0
loop do
  y, x = position.split("-").map(&:to_i)
  pipe[y][x] = maze[y][x]

  tmp = links[position].filter { |p| p!=last_position }.first
  last_position = position
  position = tmp
  length = length+1
  break if position==start
end


puts "Part 1"
puts length/2

puts "Part 2"

# figuring out what the 'S' is. This doesn't cover all cases.
y, x = start.split("-").map(&:to_i)
if ['-', '7','J'].include?(pipe[y][x+1]) then
  if ['|', 'L','J'].include?(pipe[y+1][x]) then
    pipe[y][x] = 'F'
  elsif ['|', 'F','7'].include?(pipe[y-1][x]) then
    pipe[y][x] = 'L'
  end
end

pipe.each_with_index do |row, y|
  outside = true
  row.each_with_index do |field, x|
    case field
    when '.'
      pipe[y][x] = outside ? 'O' : 'I'
    when '|', 'F', '7'
      outside = !outside
    end
  end
end

sum = 0
pipe.each do |row|
  row.each do |field|
    sum = sum+1 if field=='I'
  end
end

puts "filled"
puts sum
