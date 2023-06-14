# Petit

The Petit programming language and compiler

## Example

    factorial(integer n) = if n then n * factorial(n-1) else 1

## Grammar

    program: IDENTIFIER '(' parameters ')' '=' expression
           | program IDENTIFIER '(' parameters ')' '=' expression

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

## Exercises

1. [Lexical analysis](/exercises/ex1_lexical_analysis.md)
3. [Syntactic analysis](/exercises/ex3_syntactic_analysis.md)

