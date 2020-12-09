# frozen_string_literal: true

require 'set'

file = File.join(File.dirname(__FILE__), 'input.txt')
input = File.open(file).readlines.map(&:chomp).map(&:to_i)

INVALID_NUMBER = 776_203_571 # my result from part 1

# start with a diff of 3
i = 0
j = 2

while j < input.length && i < input.length - 2
  current_sum = input[(i..j)].reduce(:+)

  break if current_sum == INVALID_NUMBER

  j += 1 if current_sum < INVALID_NUMBER
  i += 1 if current_sum > INVALID_NUMBER
end

puts input[(i..j)].minmax.reduce(:+)

