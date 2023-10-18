#!/bin/sh
rm -f petit lex.yy.c y.tab.c y.tab.h    # delete old files
yacc -d -v -t -g --report=all petit.y   # generate y.tab.c, y.tab.h
lex petit.l                             # generate lex.yy.c
#dot y.dot -Tpng -o y.png               # LALR automaton in y.png
cc -o petit lex.yy.c y.tab.c ast.c semantics.c codegen.c -Wall -Wno-unused-function
