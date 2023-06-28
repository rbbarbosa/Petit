#include <stdio.h>

int input = -1;

int _read(int reread) {
    if(!reread)
        scanf("%d", &input);
    return input;
}

int _write(int i) {
    printf("%d\n", i);
    return 0;
}
