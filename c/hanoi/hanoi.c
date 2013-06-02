#include <stdio.h>
#include "hanoi.h"

extern struct stacks s;

int moves = 0;

void print_stacks(void) {
    printf(" { A => [");
    int i;

    // Print stack A
    for (i = 0; i < s.A_top; i++) {
        printf(" %d", *(s.A + i));
    }
    printf(" ], B => [");

    // Print stack B
    for (i = 0; i < s.B_top; i++) {
        printf(" %d", *(s.B + i));
    }
    printf(" ], C => [");

    // Print stack C
    for (i = 0; i < s.C_top; i++) {
        printf(" %d", *(s.C + i));
    }
    printf(" ] }\n");
}

char stacks_to_char(enum stack st) {
    if (st == A) return 'A';
    if (st == B) return 'B';
    return 'C';
}

void log_move(enum stack src, enum stack dst) {
    print_stacks();
    moves++;
    printf("Move #%d: %c -> %c\n", moves, stacks_to_char(src), stacks_to_char(dst));
}

void hanoi(int n, enum stack src, enum stack dst) {
    if (n == 1) {
        log_move(src, dst);
        make_move(src, dst);
    } else {
        // Determine the "via" stack for the final move of this round
        enum stack via = (A + B + C) - src - dst;

        hanoi(n - 1, src, via);
        log_move(src, dst);
        make_move(src, dst);
        hanoi(n - 1, via, dst);
    }
}
