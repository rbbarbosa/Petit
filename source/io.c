#include <stdio.h>

int input = -1;

int _read(int i) {
    if(i == 0)
        scanf("%d", &input);
    return input;
}

int _write(int i) {
    printf("%d\n", i);
    return i;
}
