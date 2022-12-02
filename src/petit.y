/* START definitions section -- C code delimited by %{ ... %} and token declarations */

%{

#include "ast.h"

int yylex(void);
void yyerror(char *kind);

struct node *program;

%}

%token PROGRAM INTEGER DOUBLE PRINT LOOP
%token<token> IDENTIFIER NATURAL DECIMAL
%type<node> program variablelist variable statementlist statement expression

%left '+' '-'
%left '*' '/'

%union{
    char *token;
    struct node *node;
}

/* END definitions section */

/* START grammar rules section -- BNF grammar */

%%

program: PROGRAM IDENTIFIER '{' variablelist statementlist '}'
                                    { $$ = program = newnode(Program, NULL);
                                      addchild($$, newnode(Identifier, $2));
                                      addchild($$, $4);
                                      addchild($$, $5); }
    ;

variablelist: /* epsilon */         { $$ = newnode(VarList, NULL); }
    | variablelist variable         { if($1->category != VarList) {
                                        $$ = newnode(VarList, NULL);
                                        addchild($$, $2);
                                      } else {
                                        $$ = $1;
                                        addchild($$, $2);
                                      } }
    ;

variable: INTEGER IDENTIFIER        { $$ = newnode(VarDecl, NULL);
                                      addchild($$, newnode(Integer, NULL));
                                      addchild($$, newnode(Identifier, $2)); }
    | DOUBLE IDENTIFIER             { $$ = newnode(VarDecl, NULL);
                                      addchild($$, newnode(Double, NULL));
                                      addchild($$, newnode(Identifier, $2)); }
    ;

statementlist: /* epsilon */        { $$ = newnode(StmtList, NULL); }
    | statementlist statement       { if($1->category != StmtList) {
                                        $$ = newnode(StmtList, NULL);
                                        addchild($$, $2);
                                      } else {
                                        $$ = $1;
                                        addchild($$, $2);
                                      } }
    ;

statement: PRINT expression         { $$ = newnode(Print, NULL);
                                      addchild($$, $2); }
    | IDENTIFIER '=' expression     { $$ = newnode(Assign, NULL);
                                      addchild($$, newnode(Identifier, $1));
                                      addchild($$, $3); }
    | LOOP expression '{' statementlist '}'
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
    | expression '-' expression     { $$ = newnode(Subtract, NULL);
                                      addchild($$, $1);
                                      addchild($$, $3); }
    | expression '*' expression     { $$ = newnode(Multiply, NULL);
                                      addchild($$, $1);
                                      addchild($$, $3); }
    | expression '/' expression     { $$ = newnode(Divide, NULL);
                                      addchild($$, $1);
                                      addchild($$, $3); }
    ;

%%

/* END grammar rules section */

/* START subroutines section */

/* all user-defined functions are collected in the .l and ast.* files */

/* END subroutines section */
