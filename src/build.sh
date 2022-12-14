#!/bin/sh
rm -f petit lex.yy.c y.tab.c y.tab.h            					# delete old files
yacc -d -t -v -g --report=all petit.y           					# generate y.tab.c, y.tab.h
flex petit.l                                    					# generate lex.yy.c
gcc ast.c semantics.c codegen.c lex.yy.c y.tab.c -Wall -Wno-unused-function -o petit	# compile and link
#dot y.dot -Tpng -o y.png                       					# LALR automaton in y.png

# run syntax tests
echo "\n[syntax tests]\n"
./petit -t < ../test/factorial.pti
./petit -t < ../test/fibonacci.pti
./petit -t < ../test/fullgrammar.pti
