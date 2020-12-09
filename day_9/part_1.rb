# frozen_string_literal: true

require 'set'

file = File.join(File.dirname(__FILE__), 'input.txt')
input = File.open(file).readlines.map(&:chomp).map(&:to_i)

BATCH_SIZE = 25

def sum?(array, target)
  curr = Set.new
  array.each do |value|
    missing_part = target - value
    return true if curr.include?(missing_part)

    curr.add(value)
  end
  false
end

(BATCH_SIZE...input.length).each do |index|
  value = input[index]
  puts value unless sum?(input[index - BATCH_SIZE...index], value)
end

