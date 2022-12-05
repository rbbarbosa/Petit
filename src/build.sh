#!/bin/sh
rm -f petit lex.yy.c y.tab.c y.tab.h            					# delete old files
yacc -d -t -v -g --report=all petit.y           					# generate y.tab.c, y.tab.h
flex petit.l                                    					# generate lex.yy.c
gcc ast.c semantics.c codegen.c lex.yy.c y.tab.c -Wall -Wno-unused-function -o petit	# compile and link
#dot y.dot -Tpng -o y.png                       					# LALR automaton in y.png

# run syntax tests
echo "\n[syntax tests]\n"
./petit -t < ../test/empty.pti
echo
./petit -t < ../test/simple.pti
echo
./petit -t < ../test/print.pti

# run semantics tests
echo "\n[semantics tests]\n"
./petit -s < ../test/empty.pti
echo
./petit -s < ../test/simple.pti
echo
./petit -s < ../test/print.pti

# run code generation tests
echo "\n[code generation tests]\n"
./petit < ../test/print.pti
echo
./petit < ../test/simplesum.pti
echo
./petit < ../test/varsum.pti
