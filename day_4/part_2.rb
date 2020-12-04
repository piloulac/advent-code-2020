# frozen_string_literal: true

require 'set'

file = File.join(File.dirname(__FILE__), 'input.txt')
input = File.open(file).readlines.map(&:chomp) << '' # adding fake empty line to count last iteration

REQUIRED_FIELDS = %w[byr iyr eyr hgt hcl ecl pid].freeze
@current_remaining_fields = Set.new(REQUIRED_FIELDS)
@valid_ctn = 0

def reset_new_passport
  @valid_ctn += 1 if @current_remaining_fields.empty?
  @current_remaining_fields = Set.new(REQUIRED_FIELDS) # reset required fields
end

RULES = {
  'byr' => ->(value) { value.to_i.between?(1920, 2002) },
  'iyr' => ->(value) { value.to_i.between?(2010, 2020) },
  'eyr' => ->(value) { value.to_i.between?(2020, 2030) },
  'hgt' => lambda do |value|
    match = /^\d+(cm|in)$/.match(value)
    return false if match.nil?

    return value.to_i.between?(150, 193) if match[1] == 'cm'

    value.to_i.between?(59, 76) # values for 'in'
  end,
  'hcl' => ->(value) { /^#[a-f0-9]{6}$/.match?(value) },
  'ecl' => ->(value) { %w[amb blu brn gry grn hzl oth].include?(value) },
  'pid' => ->(value) { value.match?(/^\d{9}$/) },
  'cid' => ->(_value) { true }
}.freeze

input.each do |row|
  reset_new_passport if row.empty?

  fields = row.split(' ')
  fields.each do |field|
    id, value = field.split(':')
    @current_remaining_fields.delete(id) if RULES.fetch(id).call(value)
  end
end

puts @valid_ctn
