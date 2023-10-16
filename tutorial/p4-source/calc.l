%{
#include "y.tab.h"
int yyparse(void);
%}
digit   [0-9]
%%
{digit}+                { yylval = atoi(yytext); return NATURAL; }
[()=,*/+-]              { return yytext[0]; }
\n                      { return 0; }
.                       { printf("Unrecognized character\n"); }
%%
int main() {
    yyparse();
    return 0;
}
int yywrap() {
    return 1;
}
