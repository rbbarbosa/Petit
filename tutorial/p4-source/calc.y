%{
#include <stdio.h>
extern int yylex(void);
void yyerror(char *);
extern char *yytext;
%}

%token IDENTIFIER NATURAL DECIMAL INTEGER DOUBLE IF THEN ELSE

%%

program: IDENTIFIER '(' parameters ')' '=' expression
                                          { }
       ;

parameters: parameter                     { }
    | parameters ',' parameter            { }
    ;

parameter: INTEGER IDENTIFIER             { }
    | DOUBLE IDENTIFIER                   { }
    ;

arguments: expression                     { }
    | arguments ',' expression            { }
    ;

expression: IDENTIFIER                    { }
          | NATURAL                       { }
          | DECIMAL                       { }
          | IDENTIFIER '(' arguments ')'  { }
          | IF expression THEN expression ELSE expression
                                          { }
          | expression '+' expression     { }
          | expression '-' expression     { }
          | expression '*' expression     { }
          | expression '/' expression     { }
          | '(' expression ')'            { }
          ;

%%

void yyerror(char *error) {
    printf("%s '%s'\n", error, yytext);
}
