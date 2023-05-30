#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ast.h"
#include "semantics.h"

int semantic_errors = 0;

struct symbol_list *symbol_table;

/* Exercise 3. check for usage of undeclared identifiers in expressions */
void check_expression(struct node *expression, struct symbol_list *scope) {
    switch(expression->category) {
        case Identifier:
            if(search_symbol(scope, expression->token) != NULL) {
                expression->type = search_symbol(scope, expression->token)->type;
            } else {
                printf("Variable %s (%d:%d) undeclared\n", expression->token, expression->token_line, expression->token_column);
                semantic_errors++;
            }
            break;
        case Natural:
            expression->type = integer_type;
            break;
        case Decimal:
            expression->type = double_type;
            break;
        case Call:
            /* check that the right parameters are used in the call and the function exists*/
            /* or maybe not... if we want to allow linking with io.c without fuss */
            break;
        case If:
            break;
        case Add:
        case Sub:
        case Mul:
        case Div:
            check_expression(getchild(expression, 0), scope);
            check_expression(getchild(expression, 1), scope);
            break;
        default:
            break;
    }
}

/* Exercise 1. show errors when parameters have identifiers that are already declared */
void check_parameters(struct node *parameters, struct symbol_list *scope) {
    struct node_list *parameter = parameters->children;
    while((parameter = parameter->next) != NULL) {
        struct node *id = getchild(parameter->node, 1);
        enum type type = category_type(getchild(parameter->node, 0)->category);
        if(search_symbol(symbol_table, id->token) == NULL) {
            insert_symbol(symbol_table, id->token, type, parameter->node);
            insert_symbol(scope, id->token, type, parameter->node);
        } else {
            printf("Identifier %s (%d:%d) already declared\n", id->token, id->token_line, id->token_column);
            semantic_errors++;
        }
    }
}

void check_function(struct node *function) {
    struct node *id = getchild(function, 0);
    if(search_symbol(symbol_table, id->token) == NULL) {
        insert_symbol(symbol_table, id->token, no_type, function);
    } else {
        /* Exercise 2. modify the overall code so that semantic errors show the line and the column (yylloc) */
        printf("Identifier %s (%d:%d) already declared\n", id->token, id->token_line, id->token_column);
        semantic_errors++;
    }
    struct symbol_list *scope = (struct symbol_list *) malloc(sizeof(struct symbol_list));
    scope->next = NULL;
    check_parameters(getchild(function, 1), scope);
    check_expression(getchild(function, 2), scope);
    /* scope should be free'd */
}

// semantic analysis begins here, with the AST root node
int check_program(struct node *program) {
    symbol_table = (struct symbol_list *) malloc(sizeof(struct symbol_list));
    symbol_table->next = NULL;
    struct node_list *child = program->children;
    while((child = child->next) != NULL)
        check_function(child->node);
    return semantic_errors;
}

struct symbol_list *insert_symbol(struct symbol_list *symbol_table, char *identifier, enum type type, struct node *node) {
    struct symbol_list *new = (struct symbol_list *) malloc(sizeof(struct symbol_list));
    new->identifier = strdup(identifier);
    new->type = type;
    new->node = node;
    new->next = NULL;
    struct symbol_list *symbol = symbol_table;
    while(symbol != NULL) {
        if(symbol->next == NULL) {
            symbol->next = new;    /* insert new symbol at the tail of the list */
            break;
        } else if(strcmp(symbol->next->identifier, identifier) == 0) {
            return NULL;           /* return NULL if symbol is already inserted */
        }
        symbol = symbol->next;
    }
    return new;
}

struct symbol_list *search_symbol(struct symbol_list *symbol_table, char *identifier) {
    struct symbol_list *symbol;
    for(symbol = symbol_table->next; symbol != NULL; symbol = symbol->next)
        if(strcmp(symbol->identifier, identifier) == 0)
            return symbol;
    return NULL;
}

void show_symbol_table() {
    struct symbol_list *symbol;
    for(symbol = symbol_table->next; symbol != NULL; symbol = symbol->next)
        printf("Symbol %s : %s\n", symbol->identifier, type_name(symbol->type));
}

/* Exercise 4. calculate the type of expression nodes, show the annotated tree */
/* Exercise 5. check calls with right number of parameters and type */