#ifndef _AST_H
#define _AST_H

enum category {  Program,   Integer,   Double,   Print,   Loop,   Identifier,   Natural,   Decimal,   VarList,   VarDecl,   StmtList,   Assign,   Add,   Subtract,   Multiply,   Divide };
#define names { "Program", "Integer", "Double", "Print", "Loop", "Identifier", "Natural", "Decimal", "VarList", "VarDecl", "StmtList", "Assign", "Add", "Subtract", "Multiply", "Divide" }

struct node {
    enum category category;
    char *token;
    struct node_list *children;
};

struct node_list {
    struct node *node;
    struct node_list *next;
};

struct node *newnode(enum category category, char *token);
void addchild(struct node *parent, struct node *child);
struct node *getchild(struct node *parent, int position);
int countchildren(struct node *node);
void show(struct node *root, int depth);
void deallocate(struct node *root);

#endif
