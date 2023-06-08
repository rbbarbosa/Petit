# Compiler exercises III: Semantic analysis

Semantic analysis is a crucial phase in the compilation process where the meaning and validity of a program's statements and expressions are examined. It involves a series of checks and transformations to ensure that the program adheres to the rules and constraints of the programming language.

A bit of theory: The usual semantic analysis algorithm performs a depth-first traversal of the AST (abstract syntax tree) generated during the parsing phase. It performs tasks such as annotating the tree with semantic information, type checking, symbol table construction, scope resolution, and consistency verification. It ensures that variables and functions are declared before use, enforces type compatibility, detects and reports errors related to mismatched types, or invalid operations. Semantic analysis ensures the correctness of the input program before proceeding to code generation.

## Performing semantic analysis on the AST



## References

Dragon Book