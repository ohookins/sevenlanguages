#include "hanoi.h"

extern struct stacks s;

void make_move(enum stack source, enum stack dest) {
    int disc;

    // Pop the disc off the top of the source stack
    // Can you dynamically refer to struct members?
    if (source == A) {
        disc = *(s.A + --s.A_top);
    } else if (source == B) {
        disc = *(s.B + --s.B_top);
    } else {
        disc = *(s.C + --s.C_top);
    }

    // Push the disc onto the top of the destination stack
    if (dest == A) {
        *(s.A + s.A_top++) = disc;
    } else if (dest == B) {
        *(s.B + s.B_top++) = disc;
    } else {
        *(s.C + s.C_top++) = disc;
    }
}
