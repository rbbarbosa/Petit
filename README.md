# Petit

Petit programming language and compiler

## Example

    factorial(integer n) =
        if n then n * factorial(n-1) else 1

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

## Tutorials and exercises

1. [Compilers tutorial I: Lexical analysis](/tutorial/ex1_lexical_analysis.md)
3. [Compilers tutorial III: Syntactic analysis](/tutorial/ex3_syntactic_analysis.md)
