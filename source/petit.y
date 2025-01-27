/* START definitions section -- C code delimited by %{ ... %} and token declarations */

%{

#include <stdio.h>
#include "ast.h"

int yylex(void);
void yyerror(char *);

struct node *ast;

%}

%token INTEGER DOUBLE IF THEN ELSE
%token<lexeme> IDENTIFIER NATURAL DECIMAL
%type<node> program function parameters parameter arguments expression
%type<node_list> functions

%left LOW
%left '+' '-'
%left '*' '/'

%union{
    char *lexeme;
    struct node *node;
    struct node_list *node_list;
}

%locations
%{
#define LOCATE(node, line, column) { node->token_line = line; node->token_column = column; }
%}

/* START grammar rules section -- BNF grammar */

%%

program: functions                  { ast = $$ = newnode(Program, NULL);
                                      addchildren($$, $1); }
    ;

functions: function                 { $$ = newlist();
                                      append($$, $1); }
    | functions function            { append($$, $2); }
    ;

function: IDENTIFIER '(' parameters ')' '=' expression
                                    { $$ = newnode(Function, NULL);
                                      addchild($$, newnode(Identifier, $1));
                                      addchild($$, $3);
                                      addchild($$, $6);
                                      LOCATE(getchild($$, 0), @1.first_line, @1.first_column); }
    ;

parameters: parameter               { $$ = newnode(Parameters, NULL);
                                      addchild($$, $1); }
    | parameters ',' parameter      { $$ = $1;
                                      addchild($$, $3); }
    ;

parameter: INTEGER IDENTIFIER       { $$ = newnode(Parameter, NULL);
                                      addchild($$, newnode(Integer, NULL));
                                      addchild($$, newnode(Identifier, $2)); 
                                      LOCATE(getchild($$, 1), @2.first_line, @2.first_column); }
    | DOUBLE IDENTIFIER             { $$ = newnode(Parameter, NULL);
                                      addchild($$, newnode(Double, NULL));
                                      addchild($$, newnode(Identifier, $2));
                                      LOCATE(getchild($$, 1), @2.first_line, @2.first_column); }
    ;

arguments: expression               { $$ = newnode(Arguments, NULL);
                                      addchild($$, $1); }
    | arguments ',' expression      { $$ = $1;
                                      addchild($$, $3); }
    ;

expression: IDENTIFIER              { $$ = newnode(Identifier, $1);
                                      LOCATE($$, @1.first_line, @1.first_column); }
    | NATURAL                       { $$ = newnode(Natural, $1); }
    | DECIMAL                       { $$ = newnode(Decimal, $1); }
    | IDENTIFIER '(' arguments ')'  { $$ = newnode(Call, NULL);
                                      addchild($$, newnode(Identifier, $1));
                                      addchild($$, $3);
                                      LOCATE(getchild($$, 0), @1.first_line, @1.first_column); }
    | IF expression THEN expression ELSE expression  %prec LOW
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

%%

/* START subroutines section */

// all needed functions are collected in the .l and ast.* files
