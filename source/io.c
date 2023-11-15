#include <stdio.h>
#include <stdlib.h>
#include <string.h>

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

int size = 0;
int *memory;

int _set(int address, int value) {
    if(address >= size)
        memory = (int *) realloc(memory, (size = address+1) * sizeof(int *));
    memory[address] = value;
    return value;
}

int _get(int address) {
    if(address < 0 || address >= size)
        return 0;
    return memory[address];
}
