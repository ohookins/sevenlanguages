#!/usr/bin/env ruby
require 'pp'

STACK = {
  'A' => [],
  'B' => [],
  'C' => []
}
discs = (ARGV[0] || 4).to_i
$moves = 0

# Populate source stack
for i in 1..discs do
  STACK['A'].unshift i
end

def log_move(src, dst)
  pp STACK
  $moves += 1
  puts "Move ##{$moves}: #{src} -> #{dst}"
end

def hanoi(discs, src, via, dst)
  if discs == 1
    log_move(src, dst)
    STACK[dst].push(STACK[src].pop)
  else
    hanoi(discs - 1, src, dst, via)
    log_move(src, dst)
    STACK[dst].push(STACK[src].pop)
    hanoi(discs - 1, via, src, dst)
  end
end

hanoi(discs, 'A', 'B', 'C')
pp STACK
puts "Number of moves required: #{$moves}"
