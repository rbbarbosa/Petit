#include <stdio.h>

int input = -1;

// read an integer from stdin
int _read(int reread) {
    if(!reread)
        scanf("%d", &input);
    return input;
}

// write an integer to stdout
int _write(int i) {
    printf("%d\n", i);
    return 0;
}
