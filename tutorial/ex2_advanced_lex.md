# Compiler exercises II: Advanced _lex_ features

Start conditions are used to specify different states in which the lexical analyzer can be, based on specific rules and patterns. Each start condition represents a distinct set of rules that are active when that condition is triggered. By using start conditions, _Lex_ allows for more flexible and modular specification of token recognition based on the current lexical context.

Start conditions & YY_USER_ACTION

## Pre-declared functions and variables

Summary of the most relevant

| Name                | Description                          |
| ------------------- | ------------------------------------ |
| ``int yylex(void)`` | Call the lexical analyser            |
| ``char *yytext`` 	  | Pointer to the matched token        |
| ``yyleng``          | Length of the matched token         |
| ``yylval``          | Semantic value associated with a token |
| ``YY_USER_ACTION``  | Macro executed before every matched rule's action |
| ECHO | Print the matched string |
| int yywrap(void) | Called on end-of-file, return 1 to stop |
| BEGIN condition | Switch to a specific start condition |
| INITIAL |	The initial start condition (same as 0) |
| %X condition(s) | Declare the names of exclusive start conditions |





To use _lex_, we specify patterns using regular expressions, along with corresponding actions. _Lex_ then transforms these rules into a C program that functions as the lexical analyser. When the lexical analyser is executed, it scans the input text, recognises the patterns specified in the rules and triggers the corresponding actions which are user-written code snippets.

A _lex_ source file has three sections separated with the `%%` delimiter:

    ...definitions...
    %% 
    ...rules...
    %% 
    ...subroutines...

The _rules_ section contains our lexical specification: regular expressions matching the patterns we are interested in, paired with snippets of C code. A simple specification is:

    %%
    [0-9]+                      { printf("NATURAL\n"); }

This _lex_ specification matches sequences of digits, found in the input text, and the corresponding action is to print the word ``NATURAL`` each time. Any other unspecified patterns are directly copied to the output without modification.

We can add a rule for decimal numerals:

    %%
    [0-9]+                      { printf("NATURAL\n"); }
    [0-9]*"."[0-9]+             { printf("DECIMAL\n"); }

If we ran this analyser, it would replace all naturals with the word ``NATURAL`` and all decimals with the word ``DECIMAL``, leaving any other characters unchanged.

In the _definitions_ section that comes before the rules, we can place abbreviations to avoid repetitions and make specifications easier to read. For example, we can use ``{digit}`` instead of ``[0-9]`` by placing ``digit`` in the definitions section. In the _subroutines_ section that comes after the rules, we write any C functions we need, typically including functions ``main()`` and ``yywrap()``. Therefore, our first complete example is as follows:

    digit   [0-9]
    %%
    {digit}+                    { printf("NATURAL\n"); }
    {digit}*"."{digit}+         { printf("DECIMAL\n"); }
    %%
    extern int yylex();
    int main() {
        yylex();    /* run the lexical analysis automaton */
        return 0;
    }
    int yywrap() {  /* called on EOF, return 1 to terminate */
        return 1;
    }

## Generating and running a lexical analyser

Having the above specification in a file named ``lexer.l``, we obtain the C code for the lexical analyser by entering:

    $ lex lexer.l

The generated source code is written to a file called ``lex.yy.c`` by default. We simply compile it using a C compiler:

    $ cc lex.yy.c -o lexer

The resulting executable file ``lexer`` reads from ``stdin`` and writes to ``stdout``. We can then run the analyser:

    $ ./lexer

Try it with integers, decimals and other tokens.

A bit of theory: The transition table which represents the lexical analysis DFA is stored in the ``lex.yy.c`` file (around source line ~400). If it weren't for _lex_ we would have to manually create these tables.


## Exercises

The following exercises start with the solution to the previous exercises in file ``lexer.l``.

1. Comments of the type /* ... */ keeping line and column correctly updated. unterminated ones are allowed

2. final exercise on illegal strings, to work on states; single line (no line border crossing) and C like backslash escape valid/invalid 

Finally, test the complete lexical analyser on the following input:

    factorial(integer n) =
        if n then n * factorial(n-1) else 1
        #

The lexer should output the 19 tokens, followed by an error message on line 3, column 5, because ``#`` is an invalid character:

    IDENTIFIER(factorial)
    (
    INTEGER
    IDENTIFIER(n)
    )
    =
    IF
    IDENTIFIER(n)
    THEN

    ...

    Unrecognized character '#' (line 3, column 5)

## Author

Raul Barbosa ([University of Coimbra](https://apps.uc.pt/mypage/faculty/uc26844))

## References

Levine, J. (2009). Flex & Bison: Text processing tools. O'Reilly Media.

Aho, A. V. (2006). Compilers: Principles, techniques and tools, 2nd edition. Pearson Education.

Niemann, T. (2016) Lex & Yacc. https://epaperpress.com/lexandyacc

Barbosa, R. (2023). Petit programming language and compiler. https://github.com/rbbarbosa/Petit
