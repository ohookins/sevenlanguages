// typedef struct stacks s;
struct stacks {
    int* A;
    int A_top;
    int* B;
    int B_top;
    int* C;
    int C_top;
};

enum stack { A, B, C };

void hanoi(int n, enum stack src, enum stack dst);

void make_move(enum stack source, enum stack dest);

void print_stacks(void);
