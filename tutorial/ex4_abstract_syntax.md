# Compiler exercises IV: Abstract syntax trees

_Yacc_ is a powerful tool for automating the creation of parsers, primarily used in language processing and compiler construction. It transforms formal grammars into executable code, making it an invaluable resource for language analysis and processing tasks. It primarily supports context-free grammars.

Previously, yacc just accepted or rejected the input sequence. Here we will construct an abstract representation.

A bit of theory: uses of parsers, constructing a syntax tree, bottom-up parsing, in reductions, we take a complete right-hand side of a rule and push the left-hand side, at that point, it is possible to relate the children to the parent node. An abstract syntax tree (AST) discards many irrelevant details while fully preserving the meaning of the original program.

type of yylval, nodes, ...

## Syntax-directed translation

To use _yacc_, we provide a grammar with snippets of C code, called actions, attached to the grammar rules. Those code snippets are executed whenever a rule is used during the parsing of an input sequence.

we PRINTFd but now we must RETURN (actually, yylex() should return)

AST nodes, data structures, key functions in ast.h, ...

## Author

Raul Barbosa [(University of Coimbra)](https://apps.uc.pt/mypage/faculty/uc26844)

## References

Aho, A. V. (2006). Compilers: Principles, techniques and tools, 2nd edition. Pearson Education.

Levine, J. (2009). Flex & Bison: Text processing tools. O'Reilly Media.

Barbosa, R. (2023). Petit programming language and compiler. https://github.com/rbbarbosa/Petit