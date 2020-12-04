# frozen_string_literal: true

require 'set'

file = File.join(File.dirname(__FILE__), 'input.txt')
input = File.open(file).readlines.map(&:chomp) << '' # adding fake empty line to count last iteration

@required_fields = Set.new(%w[byr iyr eyr hgt hcl ecl pid])
@current_remaining_fields = @required_fields.dup
@valid_ctn = 0

def reset_for_new_passport
  @valid_ctn += 1 if @current_remaining_fields.empty?
  @current_remaining_fields = @required_fields.dup # reset required fields
end

input.each do |row|
  reset_for_new_passport if row.empty?

  fields = row.split(' ')
  fields.each do |field|
    id, _value = field.split(':')
    @current_remaining_fields.delete(id)
  end
end

puts @valid_ctn

