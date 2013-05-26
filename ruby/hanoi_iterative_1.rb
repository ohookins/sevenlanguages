#!/usr/bin/env ruby
require 'pp'

STACKS = {
  'A' => [],
  'B' => [],
  'C' => []
}
discs = ARGV[0].to_i || 4
$moves = 0

def get_via(source, dest)
  # This only works for three stacks
  STACKS.keys.sort.map { |i| i[0] - 'A'[0] }.reduce(:+) - (source[0] - 'A'[0]) - (dest[0] - 'A'[0])
end

def make_move(source, dest)
  $moves += 1
  STACKS[dest].push(STACKS[source].pop)
  puts "Move ##{$moves}: #{source} -> #{dest}"
end

def comp(disc1, disc2)
  if disc1.nil?
    false
  elsif disc2.nil?
    true
  else
    disc1 < disc2
  end
end

# Populate source stack
for i in 1..discs do
  STACKS['A'].unshift i
end

first = discs.even? ? 'B' : 'C'
second = discs.even? ? 'C' : 'B'

loop do
  pp STACKS

  if comp(STACKS['A'].last, STACKS[first].last)
    make_move('A',first)
  else
    make_move(first,'A')
  end
  break if STACKS['C'].length == discs

  pp STACKS

  if comp(STACKS['A'].last, STACKS[second].last)
    make_move('A',second)
  else
    make_move(second,'A')
  end
  break if STACKS['C'].length == discs

  pp STACKS

  if comp(STACKS['B'].last, STACKS['C'].last)
    make_move('B','C')
  else
    make_move('C','B')
  end
  break if STACKS['C'].length == discs
end

puts "Number of moves required: #{$moves}"
pp STACKS
