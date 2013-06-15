package main

import (
	"flag"
	"fmt"
)

const (
	A = iota
	B
	C
)

type stack struct {
	Name  string
	Discs []int
}

func (s *stack) pop() int {
	stack_length := len(s.Discs)
	disc := s.Discs[stack_length-1]
	s.Discs = s.Discs[0 : stack_length-1]
	return disc
}

func (s *stack) push(disc int) {
	s.Discs = append(s.Discs, disc)
}

var (
	discs  = flag.Int("discs", 7, "Number of discs to use.")
	moves  = 0
	stacks []*stack
)

func init() {
	flag.Parse()
}

func main() {
	fmt.Printf("Solving Towers of Hanoi for %d discs\n", *discs)

	// Create the stacks
	stacks = make([]*stack, 3, 3)
	stacks[A] = &stack{"A", make([]int, 0, *discs)}
	stacks[B] = &stack{"B", make([]int, 0, *discs)}
	stacks[C] = &stack{"C", make([]int, 0, *discs)}

	// Create the discs
	for i := 0; i < *discs; i++ {
		stacks[A].Discs = append(stacks[A].Discs, i)
	}

	hanoi(*discs, A, C)
}

func via_stack(src, dst int) int {
	return A + B + C - src - dst
}

func hanoi(d, src, dst int) {
	via := via_stack(src, dst)
	if d > 1 {
		hanoi(d-1, src, via)
	}

	moves++
	stacks[dst].push(stacks[src].pop())
	fmt.Printf("Move #%d: %s -> %s\n", moves, stacks[src].Name, stacks[dst].Name)

	if d > 1 {
		hanoi(d-1, via, dst)
	}
}
