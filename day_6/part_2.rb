# frozen_string_literal: true

file = File.join(File.dirname(__FILE__), 'input.txt')
input = File.open(file).readlines.map(&:chomp)<<'' # hach to process all values

@ctn=0
@people_in_group=0
@curr={}

def compute_and_reset
  @ctn+=@curr.keys.reject {|key| @curr[key] != @people_in_group}.size
  @curr={}
  @people_in_group=0
end

input.each do |row|
  if row.empty?
    compute_and_reset
    next
  end

  @people_in_group+=1
  row.chars.each do |char|
    @curr[char] = @curr.key?(char) ? @curr[char]+1 : 1  
  end
end

puts @ctn