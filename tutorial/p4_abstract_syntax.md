# Compiler exercises IV: Abstract syntax

_Yacc_ is a powerful tool for automating the creation of parsers, by transforming formal grammars into executable code. 

A bit of theory:  Whenever a production is used, during syntax analysis, its _action_ is executed. One of the main uses of these schemes is to build syntax trees. Every time a production is used during bottom-up parsing, the corresponding action can _create_ new nodes and _relate_ a children node to its parent. An abstract syntax tree (AST) discards many irrelevant details while fully preserving the meaning of the original program.

## Abstract syntax trees

Trees can be represented in a number of ways. The data structure below specifies that a _node_ in the abstract syntax tree (AST) has a linked list of _children nodes_:

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

Every node also includes a pointer to the original _token_. The token is important because, for example, a node of category ``Identifier`` requires the name of the function or variable, and a node of category ``Natural`` requires the string of digits representing the natural constant.

To build an AST we only require two operations: creating a new node and adding a child node to a parent node. Two functions provide that functionality:

    struct node *newnode(enum category category, char *token);

    void addchild(struct node *parent, struct node *child);

The first function allocates memory for a new node and initializes all its fields (including an empty list of children). The second function adds a child node to the list of children of the parent node.

## Syntax-directed translation

A syntax-directed translation (SDT) scheme consists of a grammar with attached program fragments (called _actions_).

During bottom-up parsing

To use _yacc_, we provide a grammar with fragments of C code, called actions, attached to the grammar rules. Those code snippets are executed whenever a rule is used during the parsing of an input sequence.

we PRINTFd but now we must RETURN (actually, yylex() should return)

AST nodes, data structures, key functions in ast.h, ...

# Token types and unions

By default, yylval has type of int. So does the value stack.

%token INTEGER DOUBLE IF THEN ELSE
%token<token> IDENTIFIER NATURAL DECIMAL
%type<node> program parameters parameter arguments expression

%union{
    char *token;
    struct node *node;
}


## Exercises

1. Complete the code marked with \texttt{...} so that an AST is constructed for each program, using the supplied functions \texttt{newnode()} and \texttt{addchild()}.

2. Print the syntax tree

    void show(struct node *node, int depth) {
        int i;
        for(i = 0; i < depth; i++)
            printf("__");
        printf("%s\n", category_name(node->category));
        struct node_list *child = node->children;
        while((child = child->next) != NULL)
            show(child->node, depth+1);
    }

category_name could be an array or a function

3. Modify the grammar to allow for multiple functions.

## Author

Raul Barbosa ([University of Coimbra](https://apps.uc.pt/mypage/faculty/uc26844))

## References

Aho, A. V. (2006). Compilers: Principles, techniques and tools, 2nd edition. Pearson Education.

Levine, J. (2009). Flex & Bison: Text processing tools. O'Reilly Media.

Barbosa, R. (2023). Petit programming language and compiler. https://github.com/rbbarbosa/Petit