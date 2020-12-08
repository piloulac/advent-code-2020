# frozen_string_literal: true

require 'set'

file = File.join(File.dirname(__FILE__), 'input.txt')
input = File.open(file).readlines.map(&:chomp)

def run_program(program)
  index = 0
  acc = 0
  instructions_visited = Set.new

  while index < program.length
    full_instruction = program[index]
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

  { index: index, accumulator: acc }
end

# trying one/one the new combinaisons
(0...input.length).each do |index|
  next if input[index] == 'acc'

  new_input = input.dup
  new_input[index] = new_input[index].gsub('jmp', 'nop') if input[index].start_with?('jmp')
  new_input[index] = new_input[index].gsub('nop', 'jmp') if input[index].start_with?('nop')

  program_result = run_program(new_input)

  # stop if we reached the end of the program
  if program_result[:index] == input.length
    puts program_result[:accumulator]
    break
  end
end

