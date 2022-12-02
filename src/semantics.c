#include <stdio.h>
#include "ast.h"

int check_vardecl(struct node *vardecl) {
    printf("Variable %s of type ", getchild(vardecl, 1)->token);
    switch(getchild(vardecl, 0)->category) {
        case Integer:
            printf("Integer\n");
            break;
        case Double:
            printf("Double\n");
            break;
        default:
            break;
    }
    /* add to symbol table and report "symbol already declared" errors */
    return 0;
}

int check_varlist(struct node *varlist) {
    int errors = 0;
    int i;
    for(i = 0; i < countchildren(varlist); i++)
        errors += check_vardecl(getchild(varlist, i));
    return errors;
}

int check_program(struct node *program) {
    int errors = 0;
    errors += check_varlist(getchild(program, 1));
    return errors;
}

/* precisamos mesmo dos 'errors' e têm mesmo de ser declarados em todas as funções? */
/* só deveríamos colocar aqui as funções newnode() e addchild()...*/