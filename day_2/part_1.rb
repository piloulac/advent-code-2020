# frozen_string_literal: true

file = File.join(File.dirname(__FILE__), 'input.txt')
input = File.open(file).readlines.map(&:chomp)

def extract_rule(rule)
  range, letter = rule.split(' ')
  min, max = range.split('-').map(&:to_i)
  [min, max, letter]
end

valid = 0
input.each do |row|
  rule, pwd = row.split(':')
  min, max, letter = extract_rule(rule)
  valid += 1 if pwd.count(letter).between?(min,max)
end

puts valid

