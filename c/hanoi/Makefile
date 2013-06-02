objects = main.o hanoi.o move.o
CFLAGS := -std=c99 -pedantic -Wall -Wextra -Wstrict-prototypes -Wno-unused-parameter

hanoi: $(objects)
	$(CC) $(CFLAGS) -o $@ $^
