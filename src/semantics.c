#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ast.h"
#include "semantics.h"

struct table_element *symbol_table = NULL;
int semantic_errors = 0;

void check_variable(struct node *variable) {
    if(search_symbol(getchild(variable, 1)->token) != NULL) {
        /* Exercise 1. modify the overall code so that semantic errors show the line and the column */
        printf("Variable %s already declared\n", getchild(variable, 1)->token);
        semantic_errors++;
    } else {
        switch(getchild(variable, 0)->category) {
            case Integer:
                insert_symbol(getchild(variable, 1)->token, integer_type);
                break;
            case Double:
                insert_symbol(getchild(variable, 1)->token, double_type);
                break;
            default:
                break;
        }
    }
}

void check_statement(struct node *statement) {
    switch(statement->category) {
        case Assign:
            /* Exercise 2. report usage of undeclared variables in the left side of assignments */
            break;
        default:
            break;
    }
}

void check_varstmtlist(struct node *varstmtlist) {
    int i = 0;
    struct node *child;
    while((child = getchild(varstmtlist, i++)) != NULL)
        if(child->category == Variable)
            check_variable(child);
        else
            check_statement(child);
}

int check_program(struct node *program) {
    check_varstmtlist(getchild(program, 1));
    return semantic_errors;
}

struct table_element *insert_symbol(char *identifier, enum type type) {
	struct table_element *new = (struct table_element *) malloc(sizeof(struct table_element));
    new->identifier = strdup(identifier);
	new->type = type;
	new->next = NULL;	

	if(symbol_table != NULL) {
        struct table_element *curr;
	    struct table_element *prev;
		for(curr = symbol_table; curr != NULL; prev = curr, curr = curr->next)
			if(strcmp(curr->identifier, identifier) == 0)
				return NULL;
		prev->next = new;
	}
	else
		symbol_table = new;
	
	return new; 
}

struct table_element *search_symbol(char *identifier) {
    struct table_element *symbol;
    for(symbol = symbol_table; symbol != NULL; symbol = symbol->next)
        if(strcmp(symbol->identifier, identifier) == 0)
            return symbol;
    return NULL;
}

void show_symbol_table() {
    struct table_element *symbol;
    for(symbol = symbol_table; symbol != NULL; symbol = symbol->next)
	    printf("| Identifier %s | Type %d |\n", symbol->identifier, symbol->type);
}
