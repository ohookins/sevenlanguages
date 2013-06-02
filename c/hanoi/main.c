#include <stdio.h>
#include <stdlib.h>
#include "hanoi.h"

struct stacks s;

extern int moves;

int main(int argc, char** argv) {
    int n = 0;
    char c;

    while ((c = getchar())) {
        if (c == EOF || c < '0' || c > '9') break;
        n = n * 10 + (c - '0');
    }
    printf("Solving for %d discs.\n", n);

    // Create the stacks
    s.A = (int*)malloc(n * sizeof(int));
    s.A_top = n; // Actually pointing to the next unassigned int
    s.B = (int*)malloc(n * sizeof(int));
    s.B_top = 0;
    s.C = (int*)malloc(n * sizeof(int));
    s.B_top = 0;

    // Create the discs
    {
        int i;
        for (i = 0; i < n; i++) {
            *(s.A + i) = i + 1;
        }
    }

    hanoi(n, A, C);
    print_stacks();
    printf("Total moves required: %d\n", moves);
    return 0;
}
