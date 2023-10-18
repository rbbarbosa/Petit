# Compilers tutorial V: Semantic analysis

Semantic analysis is a crucial phase in the compilation process where the meaning and validity of a program's statements and expressions are examined. It involves a series of checks and transformations to ensure that the program adheres to the rules and constraints of the programming language.

A bit of theory: The usual semantic analysis algorithm performs a depth-first traversal of the AST (abstract syntax tree). It performs tasks such as annotating the tree with semantic information, type checking, symbol table construction, scope resolution, and consistency verification. It ensures that variables and functions are declared before use, enforces type compatibility, detects and reports errors related to mismatched types or invalid operations. Semantic analysis ensures the correctness of the input program before proceeding to code generation.

## Performing semantic analysis on the AST

Type and scope.

## Exercises

Restrictions and assumptions: identifiers are globally scoped.

1. Modify the code to show the line and column numbers where semantic errors are identified. There are several possibilities: lexical analysis returns a token struct which includes the line and the column of the token; use locations.

2. 3. ... select a few checks from semantics.c

Restriction: there is a single symbol table for the entire program. As a consequence, functions and parameters cannot share the same name (even parameters of different functions).
\begin{enumerate}
\item Modify the code so that undeclared symbols are reported through an error message.
\item Modify the code to show the line and column numbers where semantic errors are identified. There are several possibilities: lexical analysis returns a token object; use locations.
\item Modify the code so that \textit{expression} nodes of categories Identifier, Natural and Decimal are annotated with the type (integer\_type or double\_type). Then implement the following semantic check: assigning a double (Identifier or Decimal) to an integer variable should report a compiler warning: implicit conversion from double to integer.
\item Final, long exercise: check that variables used in expressions are parameters of the respective function. This requires scopes...
\end{enumerate}

% check only for the right number of arguments! (not their type, ever, because in Petit we can promote and underpromote)

% each scope (loop, if) could have its own variables and there could be an exercise on that

% Exercise: show the symbol table

% Exercise: show tree with type annotations

% trivial exercise: check for existence of main function with integer parameter (maybe we don't want this, actually, to generate basic code without a main function, at the beginning)

% last exercise should be about annotating the tree with the types, because it takes the most time to do

## Author

Raul Barbosa ([University of Coimbra](https://apps.uc.pt/mypage/faculty/uc26844))

## References

Dragon Book