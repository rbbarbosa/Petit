# Compiler exercises IV: Code generation

Code generation is the final phase of the compilation process where the compiler translates the validated and analysed input program into executable code. The resulting code can be in machine language, assembly language, or a higher-level intermediate representation depending on the target platform.

A bit of theory: The code generation algorithm typically performs a depth-first traversal of the AST (abstract syntax tree). This traversal visits each node in the AST and generates code or instructions based on the encountered language constructs, also consulting the symbol tables. The depth-first traversal ensures that the code generation process follows the hierarchical structure of the program, allowing for proper handling of nested statements and expressions.

## Code generation



## References

Dragon Book