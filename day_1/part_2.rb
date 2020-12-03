# frozen_string_literal: true

file = File.join(File.dirname(__FILE__), 'input.txt')
input = File.open(file).readlines.map(&:chomp).map(&:to_i)

hash = {}
input.each do |val1|
  input.each do |val2|
    reste = 2020 - val1 - val2
    hash[reste] = [val1, val2] if reste.positive?
  end
end

input.each do |val|
  if hash.key?(val) && !hash[val].include?(val)
    puts (hash[val] + [val]).reduce(:*)
    break
  end
end

