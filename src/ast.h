#ifndef _AST_H
#define _AST_H

enum category {  Program,   Parameters,   Parameter,   Integer,   Double,   Identifier,   Natural,   Decimal,   Call,   If,   Add,   Sub,   Mul,   Div,   Arguments };
#define names { "Program", "Parameters", "Parameter", "Integer", "Double", "Identifier", "Natural", "Decimal", "Call", "If", "Add", "Sub", "Mul", "Div", "Arguments" }

enum type {integer_type, double_type, no_type};
#define type_name(type) (type == integer_type ? "integer" : (type == double_type ? "double" : "none"))

struct node {
    enum category category;
    char *token;
    int token_line, token_column;
    enum type type;
    struct node_list *children;
};

struct node_list {
    struct node *node;
    struct node_list *next;
};

struct node *newnode(enum category category, char *token);
void addchild(struct node *parent, struct node *child);
struct node *getchild(struct node *parent, int position);
void show(struct node *root, int depth);
void deallocate(struct node *root);

#endif
