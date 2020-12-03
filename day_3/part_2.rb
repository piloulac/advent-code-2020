# frozen_string_literal: true

file = File.join(File.dirname(__FILE__), 'input.txt')
input = File.open(file).readlines.map(&:chomp)

max_y = input.length
max_x = input.first.length

slopes = [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]
res = 1
slopes.each do |slope|
  x = y = 0
  trees_ctn = 0
  x_slope, y_slope = slope
  while y + y_slope < max_y
    x = (x + x_slope) % max_x
    y += y_slope
    trees_ctn += 1 if input[y][x] == '#'
  end
  res *= trees_ctn
end

puts res

