#include <stdio.h>

int _write(int i) {
	printf("%d\n", i);
	return i;
}

int _read(int i) {
	scanf("%d", &i);
	return i;
}
