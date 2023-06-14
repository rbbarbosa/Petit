#!/bin/sh
rm -f petit lex.yy.c y.tab.c y.tab.h            					# delete old files
yacc -d -t -v -g --report=all petit.y           					# generate y.tab.c, y.tab.h
flex petit.l                                    					# generate lex.yy.c
gcc ast.c semantics.c codegen.c lex.yy.c y.tab.c -Wall -Wno-unused-function -o petit	# compile and link
#dot y.dot -Tpng -o y.png                       					# LALR automaton in y.png

# run syntax tests
echo "\n[syntax tests]\n"
./petit -t < ../test/factorial.pt
./petit -t < ../test/fibonacci.pt
./petit -t < ../test/fullgrammar.pt

# run semantics tests
echo "\n[semantics tests]\n"
./petit -s < ../test/semantic_errors.pt
./petit -s < ../test/fibonacci.pt
./petit -s < ../test/gcd.pt
./petit -s < ../test/factorial.pt
./petit -s < ../test/fullgrammar.pt

# run code generation tests
echo "\n[code generation tests]\n"
./petit < ../test/gcd.pt
./petit < ../test/factorial.pt

# generate code, compile it, and run it
./petit < ../test/gcd.pt > ../test/gcd.ll 
llc ../test/gcd.ll -o ../test/gcd.s
clang ../test/gcd.s io.c -o ../test/gcd
../test/gcd
./petit < ../test/factorial.pt > ../test/factorial.ll 
llc ../test/factorial.ll -o ../test/factorial.s
clang ../test/factorial.s io.c -o ../test/factorial
../test/factorial

