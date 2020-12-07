# frozen_string_literal: true
require 'set'

file = File.join(File.dirname(__FILE__), 'input.txt')
input = File.open(file).readlines.map(&:chomp)

@storage = {}
EXTRATION_REGEXP = /(\d*)\s*(\w+\s\w+)\sbags*/

input.each do |rule|
  # for rule = 'light red bags contain 1 bright white bag, 2 muted yellow bags'
  # scan returns [["", "light red"], ["1", "bright white"], ["2", "muted yellow"]]
  # for rule = 'faded blue bags contain no other bags'
  # scan returns [["", "faded blue"], ["", "no other"]]
  extracted_rule = rule.scan(EXTRATION_REGEXP)

  container = extracted_rule[0][1]
  extracted_rule.drop(1).each do |can_contain|
    count, bag_type = can_contain
    next if bag_type == 'no other'

    @storage[container] = @storage.fetch(container, []) + [can_contain]
  end
end

def find_total(to_compute)
  count_str, bag_type = to_compute
  count = count_str.to_i
  if !@storage.key?(bag_type)
    return count
  end

  count + count * @storage[bag_type].map{ |bag| find_total(bag)}.reduce(:+)
end

print find_total(['1', 'shiny gold']) - 1 # -1 because we don't count the initial 'shiny gold' bag
