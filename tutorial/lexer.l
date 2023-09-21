%{
    /* place here any C variables and definitions */
%}
digit   [0-9]
%%
{digit}+                { printf("NATURAL\n"); }
{digit}*"."{digit}+     { printf("DECIMAL\n"); }
%%
extern int yylex();
int main() {
    yylex();    /* run the lexical analysis automaton */
    return 0;
}
int yywrap() {  /* called on EOF, return 1 to terminate */
    return 1;
}
