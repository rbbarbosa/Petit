#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "ast.h"

char *category_name[] = names;

struct node *newnode(enum category category, char *token) {
    struct node *new = malloc(sizeof(struct node));
    new->category = category;
    new->token = token;
    new->children = malloc(sizeof(struct node_list));
    new->children->node = NULL;
    new->children->next = NULL;
    return new;
}

void addchild(struct node *parent, struct node *child) {
    struct node_list *new = malloc(sizeof(struct node_list));
    new->node = child;
    new->next = NULL;
    struct node_list *children = parent->children;
    while(children->next != NULL)
        children = children->next;
    children->next = new;
}

struct node *getchild(struct node *parent, int position) {
    struct node_list *children = parent->children;
    while((children = children->next) != NULL)
        if(position-- == 0)
            return children->node;
    return NULL;
}

int countchildren(struct node *node) {
    int i = 0;
    while(getchild(node, i) != NULL)
        i++;
    return i;
}

void show(struct node *node, int depth) {
    int i;
    for(i = 0; i < depth; i++)
        printf("..");
    switch(node->category) {
        case Identifier:
            printf("%s(%s)\n", category_name[node->category], node->token);
            break;
        default:
            printf("%s\n", category_name[node->category]);
    }
    struct node_list *child = node->children;
    while((child = child->next) != NULL)
        show(child->node, depth+1);
}

void deallocate(struct node *node) {
    if(node != NULL) {
        struct node_list *child = node->children;
        while(child != NULL) {
            deallocate(child->node);
            struct node_list *tmp = child;
            child = child->next;
            free(tmp);
        }
        if(node->token != NULL)
            free(node->token);
        free(node);
    }
}
