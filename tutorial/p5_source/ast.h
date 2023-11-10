#ifndef _AST_H
#define _AST_H

// the order of the enum and the #define must precisely match
enum category {  Program,   Function,   Parameters,   Parameter,   Arguments,   Integer,   Double,   Identifier,   Natural,   Decimal,   Call,   If,   Add,   Sub,   Mul,   Div };
#define names { "Program", "Function", "Parameters", "Parameter", "Arguments", "Integer", "Double", "Identifier", "Natural", "Decimal", "Call", "If", "Add", "Sub", "Mul", "Div" }

enum type {integer_type, double_type, no_type};
#define type_name(type) (type == integer_type ? "integer" : (type == double_type ? "double" : "none"))
#define category_type(category) (category == Integer ? integer_type : (category == Double ? double_type : no_type))

struct node {
    enum category category;
    char *token;
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

#endif
