#!/usr/bin/env ruby
require 'pp'

puts \
'This "optimised" iterative solution is based on the part of the wikipedia
article which references this source:
http://en.wikipedia.org/wiki/Tower_of_Hanoi#cite_note-6

Unfortunately the summary of moves is incorrect so it does not work...'
exit

STACK = {
  'A' => [],
  'B' => [],
  'C' => []
}
discs = ARGV[0] || 4
discs = discs.to_i
$moves = 0

# All possible moves without constraints
MOVES = [
    ['A','B'],
    ['B','A'],
    ['A','C'],
    ['C','A'],
    ['B','C'],
    ['C','B']
]

def make_move(move)
  $moves += 1
  STACK[move[1]].push(STACK[move[0]].pop)
  puts "Move ##{$moves}: #{move[0]} -> #{move[1]}"
end

def comp(disc1, disc2)
  if disc1.nil?
    false
  elsif disc2.nil?
    true
  else
    disc1 > disc2
  end
end

# Populate source stack
# 1 to n represents largest to smallest in this implementation.
for i in 1..discs do
  STACK['A'].push i
end

# Number of discs determines the destination of the first move
next_move = [['A', discs.odd? ? 'C' : 'B']]

loop do
  pp STACK

  make_move(next_move[0])
  break if STACK['C'].length == discs

  # Begin constraints processing
  last_move = next_move[0]
  next_move = MOVES.dup

  # Don't reverse last move
  next_move.delete([last_move[1], last_move[0]])

  next_move.dup.each do |move|
    # Can't place an even disc on an even disc
    if ! STACK[move[0]].last.nil? && STACK[move[0]].last.even? and ! STACK[move[1]].last.nil? && STACK[move[1]].last.even?
      next_move.delete(move)
      next
    end

    # Can't place an odd disc on an odd disc
    if ! STACK[move[0]].last.nil? && STACK[move[0]].last.odd? and ! STACK[move[1]].last.nil? && STACK[move[1]].last.odd?
      next_move.delete(move)
      next
    end

    # Can't place a larger disc on a smaller disc
    if ! comp(STACK[move[0]].last, STACK[move[1]].last)
      next_move.delete(move)
      next
    end

    # Never do a pointless move like single disc on a stack to an empty stack
    if STACK[move[0]].length == 1 and STACK[move[1]].length == 0
      next_move.delete(move)
      next
    end
  end
end

puts "Number of moves required: #{$moves}"
pp STACK
