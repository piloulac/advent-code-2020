# frozen_string_literal: true

require 'set'

file = File.join(File.dirname(__FILE__), 'input.txt')
input = File.open(file).readlines.map(&:chomp)

index = 0
acc = 0
instructions_visited = Set.new

while index < input.length
  full_instruction = input[index]
  instruction, value_with_sign = full_instruction.split(' ')
  value = value_with_sign.match(/\d+/)[0].to_i * (value_with_sign.start_with?('+') ? 1 : -1)

   # exit before entering in an infinite loop
  break if instructions_visited.include?(index)

  instructions_visited.add(index)

  case instruction
  when 'acc'
    acc += value
    index += 1
  when 'jmp'
    index += value
  else ## this is nop instruction
    index += 1
  end
end

puts acc

