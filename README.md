# Petit

Petit programming language and compiler

## Overview

Petit is an educational programming language for learning compilers. Here's an example:

    factorial(integer n) =
        if n then n * factorial(n-1) else 1

Programs are written in an expression-oriented, functional style:

    main(integer i) = write(factorial(read(0)))

## Tutorials and exercises

1. [Tutorial I: Lexical analysis](/tutorial/p1_lexical_analysis.md)
2. [Tutorial II: Advanced lex features](/tutorial/p2_advanced_lex.md)
3. [Tutorial III: Syntactic analysis](/tutorial/p3_syntactic_analysis.md)
4. [Tutorial IV: Abstract syntax](/tutorial/p4_abstract_syntax.md)
5. [Tutorial V: Semantic analysis](/tutorial/p5_semantic_analysis.md)
6. [Tutorial VI: Code generation](/tutorial/p6_code_generation.md)
7. [Solutions for most exercises](/source/)

## Grammar

    program: functions

    functions: function
             | functions function

    function: IDENTIFIER '(' parameters ')' '=' expression

    parameters: parameter
              | parameters ',' parameter

    parameter: INTEGER IDENTIFIER
             | DOUBLE IDENTIFIER

    arguments: expression
             | arguments ',' expression

    expression: IDENTIFIER
              | NATURAL
              | DECIMAL
              | IDENTIFIER '(' arguments ')'
              | IF expression THEN expression ELSE expression
              | expression '+' expression
              | expression '-' expression
              | expression '*' expression
              | expression '/' expression
              | '(' expression ')'
