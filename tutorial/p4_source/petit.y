/* START definitions section -- C code delimited by %{ ... %} and token declarations */

%{

#include <stdio.h>
#include "ast.h"

int yylex(void);
void yyerror(char *);

struct node *program;

%}

%token INTEGER DOUBLE IF THEN ELSE
%token<lexeme> IDENTIFIER NATURAL DECIMAL
%type<node> program function parameters parameter arguments expression

%left LOW
%left '+' '-'
%left '*' '/'

%union{
    char *lexeme;
    struct node *node;
}

/* START grammar rules section -- BNF grammar */

%%

program: function                   { $$ = program = newnode(Program, NULL);
                                      addchild($$, $1); }
    ;

function: IDENTIFIER '(' parameters ')' '=' expression
                                    { $$ = newnode(Function, NULL);
                                      addchild($$, newnode(Identifier, $1));
                                      addchild($$, $3);
                                      addchild($$, $6); }
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
    | NATURAL                       { $$ = newnode(Natural, $1); }
    | DECIMAL                       { /* ... */ }
    | IDENTIFIER '(' arguments ')'  { /* ... */ }
    | IF expression THEN expression ELSE expression  %prec LOW
                                    { /* ... */ }
    | expression '+' expression     { /* ... */ }
    | expression '-' expression     { /* ... */ }
    | expression '*' expression     { /* ... */ }
    | expression '/' expression     { /* ... */ }
    | '(' expression ')'            { $$ = $2; }  
    ;

%%

/* START subroutines section */

// all needed functions are collected in the .l and ast.* files
