# frozen_string_literal: true
require 'set'
file = File.join(File.dirname(__FILE__), 'input.txt')
input = File.open(file).readlines.map(&:chomp)<<'' # hach to process all values

@ctn=0
@curr=Set.new()

def compute_and_reset
  @ctn+=@curr.size
  @curr=Set.new()
end

input.each do |row|
  compute_and_reset if row.empty?

  row.chars.each do |char|
    @curr.add(char)
  end
end

puts @ctn