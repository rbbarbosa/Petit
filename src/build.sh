#!/bin/sh
rm -f petit lex.yy.c y.tab.c y.tab.h            # delete old files
yacc -d -t -v -g --report=all petit.y           # generate y.tab.c, y.tab.h
flex petit.l                                    # generate lex.yy.c
gcc -g *.c -Wall -Wno-unused-function -o petit  # compile and link
#dot y.dot -Tpng -o y.png                       # LALR automaton in y.png

# run syntax tests
echo "[syntax tests]\n"
./petit -t < ../test/empty.pti
echo
./petit -t < ../test/simple.pti

# run semantics tests
echo "[semantics tests]\n"
./petit -s < ../test/empty.pti
echo
./petit -s < ../test/simple.pti
