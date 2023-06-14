%{
#include <stdio.h>
extern int yylex(void);
void yyerror(char *);
extern char *yytext;
%}

%token NATURAL

%%

calculator: expression                  { printf("%d\n", $1); }
          ;

expression: NATURAL                     { $$ = $1; }
          | expression '+' expression   { $$ = $1 + $3; }
          | expression '-' expression   { $$ = $1 - $3; }
          | expression '*' expression   { $$ = $1 * $3; }
          | expression '/' expression   { $$ = $1 / $3; }
          ;

%%

void yyerror(char *error) {
    printf("%s '%s'\n", error, yytext);
}
