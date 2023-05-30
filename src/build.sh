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

# run semantics tests
echo "\n[semantics tests]\n"
./petit -s < ../test/semantic_errors.pti
./petit -s < ../test/fibonacci.pti
./petit -s < ../test/gcd.pti
./petit -s < ../test/factorial.pti
./petit -s < ../test/fullgrammar.pti

# run code generation tests
echo "\n[code generation tests]\n"
./petit < ../test/gcd.pti
./petit < ../test/factorial.pti

# generate code, compile it, and run it
./petit < ../test/gcd.pti > ../test/gcd.ll 
llc ../test/gcd.ll -o ../test/gcd.s
clang ../test/gcd.s io.c -o ../test/gcd
../test/gcd
./petit < ../test/factorial.pti > ../test/factorial.ll 
llc ../test/factorial.ll -o ../test/factorial.s
clang ../test/factorial.s io.c -o ../test/factorial
../test/factorial

