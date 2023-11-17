/* START definitions section -- C code delimited by %{ ... %} and substitutions */

%{

#include "y.tab.h"
#include "ast.h"
#include "semantics.h"

#define YY_USER_ACTION { syn_line = lex_line; syn_column = lex_column; lex_column += yyleng; }
#define PASS_TOKEN() yylval.lexeme = strdup(yytext);

int yyparse(void);
void yyerror(char *);

int lex_line = 1, lex_column = 1;
int syn_line = -1, syn_column = -1;
int errors = 0;

extern struct node *program;

%}

%option noyywrap

%X COMMENT

digit   [0-9]
letter  [a-zA-Z]

/* START rules section -- regular expressions for pattern matching */

%%

integer                     { return INTEGER; }
double                      { return DOUBLE; }
if                          { return IF; }
then                        { return THEN; }
else                        { return ELSE; }
{letter}({letter}|{digit})* { PASS_TOKEN(); return IDENTIFIER; }
{digit}+                    { PASS_TOKEN(); return NATURAL; }
{digit}*"."{digit}+         { PASS_TOKEN(); return DECIMAL; }

"/*"                        { BEGIN(COMMENT); }
<COMMENT>"*/"               { BEGIN(INITIAL); }
<COMMENT>\n|\r|\r\n         { lex_line++; lex_column = 1; }
<COMMENT>.                  {;}
<COMMENT><<EOF>>            { return 0; }

[\t ]+                      {;}
\n|\r|\r\n                  { lex_line++; lex_column = 1; }
[()=,*/+-]                  { return yytext[0]; }
.                           { yyerror("unrecognized character"); }
<<EOF>>                     { YY_USER_ACTION; return 0; }

%%

/* START subroutines section -- user functions */

void yyerror(char *error) {
    errors++;
    printf("Found %s '%s' (%d,%d)\n", error, yytext, syn_line, syn_column);
}

int main(int argc, char *argv[]) {
    yyparse();
    if(errors == 0) {
        errors += check_program(program);
        if(errors == 0) {
            show_symbol_table();
            show(program, 0);
        }
    }
    return 0;
}
