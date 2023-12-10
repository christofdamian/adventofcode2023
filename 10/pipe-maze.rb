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

######################################

maze = []
STDIN.each_with_index do |row, y|
  row.strip.split("").each_with_index do |c, x|
    maze[y] ||= []
    maze[y][x] = c
  end
end

start, links = links(maze)

links[start] = links.select { |k,v| v.include?(start) }.keys

last_position = nil
position = start
length = 0
loop do
  tmp = links[position].filter { |p| p!=last_position }.first
  last_position = position
  position = tmp
  length = length+1
  break if position==start
end

puts length/2
