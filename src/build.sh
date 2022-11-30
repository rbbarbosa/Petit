#!/bin/sh
rm -f surf                                      # delete old binary
yacc -d -t -v -g --report=all surf.y          	# generate y.tab.c, y.tab.h
flex surf.l                                 	# generate lex.yy.c
gcc -g *.c -Wall -Wno-unused-function -o surf 	# compile and link
#dot y.dot -Tpng -o y.png                     	# LALR automaton in y.png

# run syntax tests
echo "[syntax tests]"
./surf -t < ../test/empty.surf
echo
./surf -t < ../test/simple.surf
