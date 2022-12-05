/* START definitions section -- C code delimited by %{ ... %} and token declarations */

%{

#include "ast.h"

int yylex(void);
void yyerror(char *kind);

struct node *program;

%}

%token PROGRAM INTEGER DOUBLE PRINT LOOP
%token<token> IDENTIFIER NATURAL DECIMAL
%type<node> program varstmtlist variable statement expression

%left '+' '-'
%left '*' '/'

%union{
    char *token;
    struct node *node;
}

/* END definitions section */

/* START grammar rules section -- BNF grammar */

%%

program: PROGRAM IDENTIFIER '{' varstmtlist '}'
                                    { $$ = program = newnode(Program, NULL);
                                      addchild($$, newnode(Identifier, $2));
                                      addchild($$, $4); }
    ;

varstmtlist: /* epsilon */          { $$ = newnode(VarStmtList, NULL); }
    | varstmtlist variable          { $$ = $1;
                                      addchild($$, $2); }
    | varstmtlist statement         { $$ = $1;
                                      addchild($$, $2); }
    ;

variable: INTEGER IDENTIFIER        { $$ = newnode(Variable, NULL);
                                      addchild($$, newnode(Integer, NULL));
                                      addchild($$, newnode(Identifier, $2)); }
    | DOUBLE IDENTIFIER             { $$ = newnode(Variable, NULL);
                                      addchild($$, newnode(Double, NULL));
                                      addchild($$, newnode(Identifier, $2)); }
    ;

statement: PRINT expression         { $$ = newnode(Print, NULL);
                                      addchild($$, $2); }
    | IDENTIFIER '=' expression     { $$ = newnode(Assign, NULL);
                                      addchild($$, newnode(Identifier, $1));
                                      addchild($$, $3); }
    | LOOP expression '{' varstmtlist '}'
                                    { $$ = newnode(Loop, NULL);
                                      addchild($$, $2);
                                      addchild($$, $4); }
    ;

expression: IDENTIFIER              { $$ = newnode(Identifier, $1); }
    | NATURAL                       { $$ = newnode(Natural, $1); }
    | DECIMAL                       { $$ = newnode(Decimal, $1); }
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
    ;

%%       /*prepare a nice demo of gdb...*/

/* END grammar rules section */

/* START subroutines section */

/* all user-defined functions needed are collected in the .l and ast.* files */

/* END subroutines section */