#!/bin/sh
rm -f petit										# delete old binary
yacc -d -t -v -g --report=all petit.y			# generate y.tab.c, y.tab.h
flex petit.l									# generate lex.yy.c
gcc -g *.c -Wall -Wno-unused-function -o petit	# compile and link
#dot y.dot -Tpng -o y.png						# LALR automaton in y.png

# run syntax tests
echo "[syntax tests]"
./petit -t < ../test/empty.pti
echo
./petit -t < ../test/simple.pti
