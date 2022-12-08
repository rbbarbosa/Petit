#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ast.h"
#include "semantics.h"

struct symbol_list *symbol_table = NULL;
int semantic_errors = 0;

void check_variable(struct node *variable) {
    if(search_symbol(getchild(variable, 1)->token) == NULL) {
        if(getchild(variable, 0)->category == Integer)
            insert_symbol(getchild(variable, 1)->token, integer_type);
        else
            insert_symbol(getchild(variable, 1)->token, double_type);
    } else {
        /* Exercise 2. modify the overall code so that semantic errors show the line and the column */
        printf("Variable %s already declared\n", getchild(variable, 1)->token);
        semantic_errors++;
    }
}

void check_statement(struct node *statement) {
    switch(statement->category) {
        case Assign:
            /* Exercise 1. show errors on assignments to undeclared variables */
            break;
        default:
            break;
    }
}

void check_varstmtlist(struct node *varstmtlist) {
    struct node_list *child = varstmtlist->children;
    while((child = child->next) != NULL)
        if(child->node->category == Variable)
            check_variable(child->node);
        else
            check_statement(child->node);
}

int check_program(struct node *program) {
    check_varstmtlist(getchild(program, 1));
    return semantic_errors;
}

struct symbol_list *insert_symbol(char *identifier, enum type type) {
    struct symbol_list *new = (struct symbol_list *) malloc(sizeof(struct symbol_list));
    new->identifier = strdup(identifier);
    new->type = type;
    new->next = NULL;	

    if(symbol_table != NULL) {
        struct symbol_list *symbol = symbol_table;
        while(symbol != NULL) {
            if(strcmp(symbol->identifier, identifier) == 0) {
                return NULL;          /* return NULL if symbol is already inserted */
            } else if(symbol->next == NULL) {
                symbol->next = new;   /* insert new symbol at the tail of the list */
                break;
            }
            symbol = symbol->next;
        }
    }
    else
        symbol_table = new;

    return new; 
}

struct symbol_list *search_symbol(char *identifier) {
    struct symbol_list *symbol;
    for(symbol = symbol_table; symbol != NULL; symbol = symbol->next)
        if(strcmp(symbol->identifier, identifier) == 0)
            return symbol;
    return NULL;
}

void show_symbol_table() {
    struct symbol_list *symbol;
    for(symbol = symbol_table; symbol != NULL; symbol = symbol->next)
        printf("| Identifier %s | Type %d |\n", symbol->identifier, symbol->type);
}
