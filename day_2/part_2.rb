# frozen_string_literal: true

file = File.join(File.dirname(__FILE__), 'input.txt')
input = File.open(file).readlines.map(&:chomp)

def extract_rule(rule)
  range, letter = rule.split(' ')
  pos1, pos2 = range.split('-').map(&:to_i)
  [pos1, pos2, letter]
end

valid = 0
input.each do |row|
  rule, pwd = row.split(':')
  pos1, pos2, letter = extract_rule(rule)
  valid += 1 if (pwd[pos1] == letter) ^ (pwd[pos2] == letter)
end

puts valid

