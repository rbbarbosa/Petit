/* START definitions section -- C code delimited by %{ ... %} and token declarations */

%{

#include "ast.h"

int yylex(void);
void yyerror(char *kind);

struct node *program;

%}

%token INTEGER DOUBLE IF THEN ELSE
%token<token> IDENTIFIER NATURAL DECIMAL
%type<node> program parameters expression

%left least
%left '+' '-'
%left '*' '/'

%union{
    char *token;
    struct node *node;
}

%locations
%{
#define LOCATE(node, line, column) { node->token_line = line; node->token_column = column; }
%}

/* END definitions section */

/* START grammar rules section -- BNF grammar */

%%

program: IDENTIFIER '(' parameters ')' '=' expression
                                    { }
    ;

parameters: parameter               { }
    | parameters ',' parameter      { }
    ;

parameter: INTEGER IDENTIFIER       { }
    | DOUBLE IDENTIFIER             { }
    ;

expression: IDENTIFIER              { }
    | NATURAL                       { }
    | DECIMAL                       { }
    | IDENTIFIER '(' arguments ')'  { }
    | IF expression THEN expression ELSE expression  %prec least
                                    { }
    | expression '+' expression     { }
    | expression '-' expression     { }
    | expression '*' expression     { }
    | expression '/' expression     { }
    | '(' expression ')'            { }  
    ;

arguments: expression               { }
    | arguments ',' expression      { }
    ;

%%

/* END grammar rules section */

/* START subroutines section */

/* all user-defined functions needed are collected in the .l and ast.* files */

/* END subroutines section */
