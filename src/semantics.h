#ifndef _SEMANTICS_H
#define _SEMANTICS_H

#include "ast.h"

int check_program(struct node *program);

struct table_element {
	char *identifier;
	enum type type;
	struct table_element *next;
};

struct table_element *insert_symbol(char *identifier, enum type type);
struct table_element *search_symbol(char *identifier);
void show_symbol_table();

#endif
