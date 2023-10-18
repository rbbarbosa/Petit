# Compiler tutorial IV: Abstract syntax

_Yacc_ is a powerful tool for generating parsers, by transforming formal grammars into executable code. In this tutorial we explore how to construct an abstract syntax tree (AST), which is a kind of parse tree which discards irrelevant details while fully preserving the meaning of the original program.

A bit of theory: A syntax-directed translation (SDT) scheme consists of a grammar with attached program fragments (called _actions_). Whenever a _production_ is used, during syntax analysis, its _action_ is executed. One of the main uses of these schemes is to build syntax trees. Every time a production is used during bottom-up parsing, the corresponding action can _create_ new nodes and/or _relate_ children nodes to the parent.

## Abstract syntax trees

Trees can be represented in a number of ways. The data structures below specify that a _node_ in the AST has a linked list of _children nodes_:

    struct node {
        enum category category;
        char *token;
        struct node_list *children;
    };

    struct node_list {
        struct node *node;
        struct node_list *next;
    };

Every node has a syntactic _category_ denoting a specific programming construct occurring in the input program, such as a function, a parameter declaration, or a natural constant:

    enum category {Program, Function, ..., Identifier, Natural, ...};

Every node also includes a pointer to the original _token_. The token is necessary because a node of category ``Identifier`` must have the name of the function or variable, a node of category ``Natural`` must have the string of digits representing the natural constant, and so on.

To build an AST we only require two operations: creating a new node and adding a child node to a parent node. Two functions provide that functionality:

    struct node *newnode(enum category category, char *token);
    void addchild(struct node *parent, struct node *child);

The first function allocates memory for a new node and initializes all its fields (including an empty list of children). The second function appends a node to the list of children of the parent node. They are provided in files [``ast.h``](https://github.com/rbbarbosa/Petit/blob/main/tutorial/p4_source/ast.h) and [``ast.c``](https://github.com/rbbarbosa/Petit/blob/main/tutorial/p4_source/ast.c).

## Syntax-directed translation

During bottom-up parsing, an action ``{...}`` is executed when the corresponding production is used. The combined result of all those executions is the AST.

Consider the following _yacc_ specification (which you will complete). Notice that it is included in file [``petit.y``](https://github.com/rbbarbosa/Petit/blob/main/tutorial/p4_source/petit.y), that you should carefully analyze.

    program: IDENTIFIER '(' parameters ')' '=' expression
                    { $$ = program = newnode(Program, NULL);
                      struct node *function = newnode(Function, NULL);
                      addchild(function, newnode(Identifier, $1));
                      addchild(function, $3);
                      addchild(function, $6);
                      addchild($$, function); }
        ;
    parameters: parameter               { /* ... */ }
        | parameters ',' parameter      { /* ... */ }
        ;
    parameter: INTEGER IDENTIFIER       { /* ... */ }
        | DOUBLE IDENTIFIER             { /* ... */ }
        ;
    arguments: expression               { /* ... */ }
        | arguments ',' expression      { /* ... */ }
        ;
    expression: IDENTIFIER              { /* ... */ }
        | NATURAL                       { /* ... */ }
        | DECIMAL                       { /* ... */ }
        | IDENTIFIER '(' arguments ')'  { /* ... */ }
        | IF expression THEN expression ELSE expression  %prec LOW
                                        { /* ... */ }
        | expression '+' expression     { /* ... */ }
        | expression '-' expression     { /* ... */ }
        | expression '*' expression     { /* ... */ }
        | expression '/' expression     { /* ... */ }
        | '(' expression ')'            { /* ... */ }  
        ;

When the first production is used, the right-hand side contains a _function_ with its ``parameters`` and ``expression``. Parsing will be finishing there. The corresponding action executes 6 statements, in the following order: _(1)_ the AST's root node ``Program`` is created; _(2)_ a new ``Function`` node is created; _(3)_ a new ``Identifier`` node is created, with the function name, and becomes a child of the ``Function`` node; _(4)_ the ``parameters`` node ``$3`` becomes a child of the ``Function`` node; _(5)_ the ``expression`` node ``$6`` becomes a child of the ``Function`` node; and _(6)_ the new ``Function`` node becomes a child of the ``Program`` node.

# Token types and unions

Summarize this from the previous tutorial: The _definitions_ section contains C code delimited by ``%{ ... %}`` and token declarations. The _rules_ section contains the grammar, in a notation similar to BNF (Backus-Naur form). The _subroutines_ section contains any C functions needed. Integrating _lex_ and _yacc_ is achieved by placing ``%token`` declarations in the definitions section of the _yacc_ source file:

    %token NATURAL

By default, in yacc, yylval has type of int. So does the value stack.

    %token INTEGER DOUBLE IF THEN ELSE
    %token<token> IDENTIFIER NATURAL DECIMAL
    %type<node> program parameters parameter arguments expression

    %union{
        char *token;
        struct node *node;
    }

yylval.token = strdup(yytext);

we PRINTFd but now we must RETURN (actually, yylex() should return)

What $$, $1 and $2 mean... with the respective type.


## Exercises

1. Complete the code marked with \texttt{/* ... */} so that an AST is constructed for each program, using only the supplied functions \texttt{newnode()} and \texttt{addchild()}.

2. Print the syntax tree

    void show(struct node *node, int depth) {
        ...
    }

category_name could be an array or a function

3. Modify the grammar to allow for multiple functions.

    program: IDENTIFIER '(' parameters ')' '=' expression
           | program IDENTIFIER '(' parameters ')' '=' expression

Test your final code with the following example: factorial (complete)

## Author

Raul Barbosa ([University of Coimbra](https://apps.uc.pt/mypage/faculty/uc26844))

## References

Aho, A. V. (2006). Compilers: Principles, techniques and tools, 2nd edition. Pearson Education.

Levine, J. (2009). Flex & Bison: Text processing tools. O'Reilly Media.

Barbosa, R. (2023). Petit programming language and compiler.  
https://github.com/rbbarbosa/Petit