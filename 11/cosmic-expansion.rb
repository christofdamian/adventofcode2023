#!/bin/ruby

def read_input
  stars = []
  STDIN.each_with_index do |line, y|
    line.strip.split("").each_with_index do |field, x|
      stars.push({y: y, x:x}) if field=='#'
    end
  end
  stars
end


def expand(stars, factor=2)
  rows = stars.map { |star| star[:y] }.sort.uniq
  columns = stars.map { |star| star[:x] }.sort.uniq

  for y in (rows.max).downto(0)
    unless rows.include?(y)
      stars.each do |star|
        star[:y] = star[:y]+factor-1 if star[:y]>y
      end
    end
  end
  for x in (columns.max).downto(0)
    unless columns.include?(x)
      stars.each do |star|
        star[:x] = star[:x]+factor-1 if star[:x]>x
      end
    end
  end
  stars
end

def sum_distances(stars)
  sum = 0
  stars.each_with_index do |a, ai|
    stars.each_with_index do |b, bi|
      next unless bi>ai
      length =(a[:x]-b[:x]).abs + (a[:y]-b[:y]).abs
      sum = sum + length
    end
  end
  sum
end

#####################################

input = read_input()

puts "Part 1"
puts sum_distances(expand(Marshal.load( Marshal.dump(input))))

puts "Part 2"
puts sum_distances(expand(Marshal.load( Marshal.dump(input)), 1_000_000))
