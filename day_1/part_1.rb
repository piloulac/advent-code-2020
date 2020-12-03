# frozen_string_literal: true

require 'set'

file = File.join(File.dirname(__FILE__), 'input.txt')
input = File.open(file).readlines.map(&:chomp).map(&:to_i)

curr = Set.new

input.each do |val|
  if curr.include?(val)
    puts val * (2020 - val)
    break
  else
    curr.add(2020 - val)
  end
end

