# Compiler exercises IV: Abstract syntax trees

_Yacc_ is a powerful tool for automating the creation of parsers, by transforming formal grammars into executable code. 

A bit of theory: A syntax-directed translation (SDT) scheme consists of a grammar with attached program fragments (called _actions_). Whenever a production is used, during syntax analysis, its action is executed. One of the main uses of these schemes is to build syntax trees. Every time a production is used during bottom-up parsing, the corresponding action can _create_ new tree nodes and _relate_ children nodes to their parent. An abstract syntax tree (AST) discards many irrelevant details while fully preserving the meaning of the original program.

## Syntax-directed translation

To use _yacc_, we provide a grammar with fragments of C code, called actions, attached to the grammar rules. Those code snippets are executed whenever a rule is used during the parsing of an input sequence.

we PRINTFd but now we must RETURN (actually, yylex() should return)

AST nodes, data structures, key functions in ast.h, ...

## Author

Raul Barbosa ([University of Coimbra](https://apps.uc.pt/mypage/faculty/uc26844))

## References

Aho, A. V. (2006). Compilers: Principles, techniques and tools, 2nd edition. Pearson Education.

Levine, J. (2009). Flex & Bison: Text processing tools. O'Reilly Media.

Barbosa, R. (2023). Petit programming language and compiler. https://github.com/rbbarbosa/Petit