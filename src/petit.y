/* START definitions section -- C code delimited by %{ ... %} and token declarations */

%{

#include "ast.h"

int yylex(void);
void yyerror(char *kind);

struct node *program;

%}

%token INTEGER DOUBLE IF THEN ELSE
%token<token> IDENTIFIER NATURAL DECIMAL
%type<node> program parameters parameter expression arguments

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
                                    { $$ = program = newnode(Program, NULL);
                                      addchild($$, newnode(Identifier, $1));
                                      addchild($$, $3);
                                      addchild($$, $6); }
    ;

parameters: parameter               { $$ = newnode(Parameters, NULL);
                                      addchild($$, $1); }
    | parameters ',' parameter      { $$ = $1;
                                      addchild($$, $3); }
    ;

parameter: INTEGER IDENTIFIER       { $$ = newnode(Parameter, NULL);
                                      addchild($$, newnode(Integer, NULL));
                                      addchild($$, newnode(Identifier, $2)); }
    | DOUBLE IDENTIFIER             { $$ = newnode(Parameter, NULL);
                                      addchild($$, newnode(Double, NULL));
                                      addchild($$, newnode(Identifier, $2)); }
    ;

expression: IDENTIFIER              { $$ = newnode(Identifier, $1); }
    | NATURAL                       { $$ = newnode(Natural, $1); }
    | DECIMAL                       { $$ = newnode(Decimal, $1); }
    | IDENTIFIER '(' arguments ')'  { $$ = newnode(Call, NULL);
                                      addchild($$, newnode(Identifier, $1));
                                      addchild($$, $3); }
    | IF expression THEN expression ELSE expression  %prec least
                                    { $$ = newnode(If, NULL);
                                      addchild($$, $2);
                                      addchild($$, $4);
                                      addchild($$, $6); }
    | expression '+' expression     { $$ = newnode(Add, NULL);
                                      addchild($$, $1);
                                      addchild($$, $3); }
    | expression '-' expression     { $$ = newnode(Sub, NULL);
                                      addchild($$, $1);
                                      addchild($$, $3); }
    | expression '*' expression     { $$ = newnode(Mul, NULL);
                                      addchild($$, $1);
                                      addchild($$, $3); }
    | expression '/' expression     { $$ = newnode(Div, NULL);
                                      addchild($$, $1);
                                      addchild($$, $3); }
    | '(' expression ')'            { $$ = $2; }  
    ;

arguments: expression               { $$ = newnode(Arguments, NULL);
                                      addchild($$, $1); }
    | arguments ',' expression      { $$ = $1;
                                      addchild($$, $3); }
    ;

%%

/* END grammar rules section */

/* START subroutines section */

/* all user-defined functions needed are collected in the .l and ast.* files */

/* END subroutines section */
