# frozen_string_literal: true

file = File.join(File.dirname(__FILE__), 'input.txt')
input = File.open(file).readlines.map(&:chomp)

max_y = input.length
max_x = input.first.length
x = y = 0

trees_ctn = 0
while y + 1 < max_y
  x = (x + 3) % max_x
  y += 1
  trees_ctn += 1 if input[y][x] == '#'
end

puts trees_ctn

