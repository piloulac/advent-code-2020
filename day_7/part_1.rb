# frozen_string_literal: true
require 'set'

file = File.join(File.dirname(__FILE__), 'input.txt')
input = File.open(file).readlines.map(&:chomp)

storage = {}
EXTRATION_REGEXP = /(\d*)\s*(\w+\s\w+)\sbags*/

input.each do |rule|
  # for rule = 'light red bags contain 1 bright white bag, 2 muted yellow bags'
  # scan returns [["", "light red"], ["1", "bright white"], ["2", "muted yellow"]]
  # for rule = 'faded blue bags contain no other bags'
  # scan returns [["", "faded blue"], ["", "no other"]]
  extracted_rule = rule.scan(EXTRATION_REGEXP)

  container = extracted_rule[0][1]
  extracted_rule.drop(1).each do |can_contain|
    _count, bag_type = can_contain
    next if bag_type == 'no other'

    storage[bag_type] = storage.fetch(bag_type, []) + [container]
  end
end

res = Set.new()
search_for = ['shiny gold']

while search_for.size > 0
  process = search_for.pop
  next unless storage.key?(process)

  res += storage[process]
  search_for += storage[process]
end

puts res.size