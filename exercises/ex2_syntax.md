# Compiler exercises II: Syntactic analysis

_Yacc_ is a powerful tool for automating the creation of parsers, primarily used in language processing and compiler construction. It transforms formal grammars into executable code, making it an invaluable resource for language analysis and processing tasks. It primarily supports context-free grammars.

A bit of theory: _Yacc_ takes the user-specified grammar rules and algorithmically constructs the corresponding LR parsing table. Specifically, it constructs an LALR(1) parser, that is, a look ahead left-to-right rightmost derivation parser. The parser takes as input the sequence of tokens passed by the lexical analyser (_lex_) and moves according to the parsing table. If it completes the derivation of the input sequence, reaching an accepting state, then the input is in the language of the grammar. Otherwise, a syntax error is found.

## Using _yacc_

To use _yacc_, we provide a grammar with snippets of C code, called actions, attached to the grammar rules. Those code snippets are executed whenever a rule is used during the parsing of an input sequence.

we PRINTFd but now we must RETURN (actually, yylex() should return)

## References

Dragon Book