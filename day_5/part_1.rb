# frozen_string_literal: true

file = File.join(File.dirname(__FILE__), 'input.txt')
input = File.open(file).readlines.map(&:chomp)

ROWS = (0..127)
COLUMNS = (0..7)

def create_bsp(range)
  return [range.min, range.max] if range.size == 2

  value_to_split = (range.max + range.min)/2
  return [create_bsp(range.min..value_to_split), create_bsp(value_to_split+1..range.max)]
end

def search_row(moves)
  search(moves, ROWS)
end

def search_column(moves)
  search(moves, COLUMNS)
end

def search(moves, init_range)
  curr_search = create_bsp(init_range)
  moves.chars.each do |move|
    curr_search = curr_search[1] if %w[R B].include?(move) 
    curr_search = curr_search[0] if %w[L F].include?(move) 
  end
  curr_search
end

ids = []
input.each do |boarding_pass|
  row = search_row(boarding_pass[0..6])
  column = search_column(boarding_pass[7..9])
  ids << row * 8 + column
end

puts ids.max