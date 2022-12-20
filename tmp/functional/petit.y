/* START definitions section -- C code delimited by %{ ... %} and token declarations */

%{

#include "ast.h"

int yylex(void);
void yyerror(char *kind);

struct node *program;

%}

%token INTEGER DOUBLE IF THEN ELSE
%token<token> IDENTIFIER NATURAL DECIMAL
%type<node> program list function parameters type statement expression

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

program: list                       { }
    ;

list: /* epsilon */                 { }
    | list function                 { }
    | list statement                { }
    ;

function: type IDENTIFIER '(' parameters ')'
                                    { }
    | type IDENTIFIER '(' parameters ')' '=' expression
                                    { }
    ;

type: INTEGER                       { }
    | DOUBLE                        { }
    ;

parameters: parameters ',' type IDENTIFIER
                                    { }
    | type IDENTIFIER               { }
    | /* epslion */                 { }
    ;    

statement: IDENTIFIER '(' arguments ')' '=' expression
                                    { }
    ;

arguments: arguments ',' expression
                                    { }
    | expression                    { }
    | /* epsilon */                 { }
    ;

expression: IDENTIFIER              { }
    | NATURAL                       { }
    | DECIMAL                       { }
    | IDENTIFIER '(' arguments ')'  { }
    | IF expression THEN expression ELSE expression %prec least
                                    { }
    | expression '+' expression     { }
    | expression '-' expression     { }
    | expression '*' expression     { }
    | expression '/' expression     { }
    | '(' expression ')'            { }  
    ;

%%

/* END grammar rules section */

/* START subroutines section */

/* all user-defined functions needed are collected in the .l and ast.* files */

/* END subroutines section */
