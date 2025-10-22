#include <stdlib.h>
#include <stdio.h>
#include "ast.h"

// create a node of a given category with a given lexical symbol
struct node *newnode(enum category category, char *token) {
    struct node *new = malloc(sizeof(struct node));
    new->category = category;
    new->token = token;
    new->type = no_type;
    new->children = malloc(sizeof(struct node_list));
    new->children->node = NULL;
    new->children->next = NULL;
    return new;
}

// append a node to the list of children of the parent node
void addchild(struct node *parent, struct node *child) {
    struct node_list *new = malloc(sizeof(struct node_list));
    new->node = child;
    new->next = NULL;
    struct node_list *children = parent->children;
    while(children->next != NULL)
        children = children->next;
    children->next = new;
}

// get a pointer to a specific child, numbered 0, 1, 2, ...
struct node *getchild(struct node *parent, int position) {
    struct node_list *children = parent->children;
    while((children = children->next) != NULL)
        if(position-- == 0)
            return children->node;
    return NULL;
}

// count the children of a node
int countchildren(struct node *node) {
    int i = 0;
    while(getchild(node, i) != NULL)
        i++;
    return i;
}

// create an empty list
struct node_list *newlist() {
    struct node_list *new = malloc(sizeof(struct node_list));
    new->node = NULL;
    new->next = NULL;
    return new;
}

// append a node to a list of nodes
void append(struct node_list *list, struct node *node) {
    struct node_list *new = malloc(sizeof(struct node_list));
    new->node = node;
    new->next = NULL;
    while(list->next != NULL)
        list = list->next;
    list->next = new;
}

// append a list of nodes as children of the given node
void addchildren(struct node *node, struct node_list *list) {
    struct node_list *children = node->children;
    while(children->next != NULL)
        children = children->next;
    children->next = list->next;
    free(list);
}

// category names #defined in ast.h
char *category_name[] = names;

// traverse the AST and print its content
void show(struct node *node, int depth) {
    int i;
    for(i = 0; i < depth; i++)
        printf("__");
    if(node->token == NULL)
        printf("%s\n", category_name[node->category]);
    else
        printf("%s(%s)\n", category_name[node->category], node->token);
    struct node_list *child = node->children;
    while((child = child->next) != NULL)
        show(child->node, depth+1);
}
