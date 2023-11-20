#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ast.h"
#include "semantics.h"
#include "codegen.h"

int temporary;

extern struct symbol_list *symbol_table;

int codegen_add(struct node *add) {
    int e1 = codegen_expression(getchild(add, 0));
    int e2 = codegen_expression(getchild(add, 1));
    printf("  %%%d = add i32 %%%d, %%%d\n", temporary, e1, e2);
    return temporary++;
}

int codegen_sub(struct node *sub) {
    int e1 = codegen_expression(getchild(sub, 0));
    int e2 = codegen_expression(getchild(sub, 1));
    printf("  %%%d = sub i32 %%%d, %%%d\n", temporary, e1, e2);
    return temporary++;
}

int codegen_mul(struct node *mul) {
    int e1 = codegen_expression(getchild(mul, 0));
    int e2 = codegen_expression(getchild(mul, 1));
    printf("  %%%d = mul i32 %%%d, %%%d\n", temporary, e1, e2);
    return temporary++;
}

int codegen_div(struct node *div) {
    int e1 = codegen_expression(getchild(div, 0));
    int e2 = codegen_expression(getchild(div, 1));
    printf("  %%%d = sdiv i32 %%%d, %%%d\n", temporary, e1, e2);
    return temporary++;
}

int codegen_natural(struct node *natural) {
    printf("  %%%d = add i32 %s, 0\n", temporary, natural->token);
    return temporary++;
}

int codegen_decimal(struct node *decimal) {
    printf("  %%%d = fadd double %s, 0.0\n", temporary, decimal->token);
    return temporary++;
}

int codegen_identifier(struct node *identifier) {
    printf("  %%%d = add i32 %%%s, 0\n", temporary, identifier->token);
    return temporary++;
}

int codegen_call(struct node *call) {
    struct node *arguments = getchild(call, 1);
    char *arguments_str = malloc(1);
    *arguments_str = '\0';
    struct node *argument;
    int curr = 0;
    while((argument = getchild(arguments, curr++)) != NULL) {
        int e = codegen_expression(argument);
        char str[18];
        if(curr > 1)
            sprintf(str, ", i32 %%%d", e);
        else
            sprintf(str, "i32 %%%d", e);
        arguments_str = realloc(arguments_str, strlen(arguments_str) + strlen(str) + 1);
        strcat(arguments_str, str);
    }
    printf("  %%%d = tail call i32 @_%s(%s)\n", temporary, getchild(call, 0)->token, arguments_str);
    return temporary++;
}

int codegen_ifthenelse(struct node *ifthenelse) {
    int label_id = temporary++;
    printf("  %%%d = alloca i32\n", label_id);
    int e = codegen_expression(getchild(ifthenelse, 0));
    printf("  %%%d = icmp ne i32 %%%d, 0\n", temporary, e);
    printf("  br i1 %%%d, label %%L%dthen, label %%L%delse\n", temporary++, label_id, label_id);
    printf("L%dthen:\n", label_id);
    int e1 = codegen_expression(getchild(ifthenelse, 1));
    printf("  store i32 %%%d, i32* %%%d\n", e1, label_id);
    printf("  br label %%L%dend\n", label_id);
    printf("L%delse:\n", label_id);
    int e2 = codegen_expression(getchild(ifthenelse, 2));
    printf("  store i32 %%%d, i32* %%%d\n", e2, label_id);
    printf("  br label %%L%dend\n", label_id);  
    printf("L%dend:\n", label_id);
    printf("  %%%d = load i32, i32* %%%d\n", temporary, label_id);
    return temporary++;
}

#define OPTIMIZE_IFS

#ifdef OPTIMIZE_IFS
// at the top level, an if-then-else will 'ret' to benefit from tail call elimination
void codegen_ifthenelse_ret(struct node *ifthenelse) {
    int e = codegen_expression(getchild(ifthenelse, 0));
    int label_id = temporary;
    printf("  %%%d = icmp ne i32 %%%d, 0\n", temporary, e);
    printf("  br i1 %%%d, label %%L%dthen, label %%L%delse\n", temporary++, label_id, label_id);
    printf("L%dthen:\n", label_id);
    if(getchild(ifthenelse, 1)->category == If) {
        codegen_ifthenelse_ret(getchild(ifthenelse, 1));
    } else {
        int e1 = codegen_expression(getchild(ifthenelse, 1));
        printf("  ret i32 %%%d\n", e1);
    }
    printf("L%delse:\n", label_id);
    if(getchild(ifthenelse, 2)->category == If) {
        codegen_ifthenelse_ret(getchild(ifthenelse, 2));
    } else {
        int e2 = codegen_expression(getchild(ifthenelse, 2));
        printf("  ret i32 %%%d\n", e2);
    }
}
#endif

int codegen_expression(struct node *expression) {
    int tmp = -1;
    switch(expression->category) {
        case Identifier:
            tmp = codegen_identifier(expression);
            break;
        case Natural:
            tmp = codegen_natural(expression);
            break;
        case Decimal:
            tmp = codegen_decimal(expression);
            break;
        case Call:
            tmp = codegen_call(expression);
            break;
        case If:
            tmp = codegen_ifthenelse(expression);
            break;
        case Add:
            tmp = codegen_add(expression);
            break;
        case Sub:
            tmp = codegen_sub(expression);
            break;
        case Mul:
            tmp = codegen_mul(expression);
            break;
        case Div:
            tmp = codegen_div(expression);
            break;
        default:
            break;
    }
    return tmp;
}

void codegen_parameters(struct node *parameters) {
    struct node *parameter;
    int curr = 0;
    while((parameter = getchild(parameters, curr++)) != NULL) {
        if(curr > 1)
            printf(", ");
        printf("i32 %%%s", getchild(parameter, 1)->token);
    }
}

void codegen_function(struct node *function) {
    temporary = 1;
    printf("define i32 @_%s(", getchild(function, 0)->token);
    codegen_parameters(getchild(function, 1));
    printf(") {\n");
#ifdef OPTIMIZE_IFS
    if(getchild(function, 2)->category == If)
        codegen_ifthenelse_ret(getchild(function, 2));  // optimized if-then-else
    else
#endif
        codegen_expression(getchild(function, 2));      // usual if-then-else
    printf("  ret i32 %%%d\n", temporary-1);
    printf("}\n\n");
}

// code generation begins here, with the AST root node
void codegen_program(struct node *program) {
    // predeclared functions
    printf("declare i32 @_read(i32)\n");
    printf("declare i32 @_write(i32)\n");
    printf("declare i32 @_set(i32, i32)\n");
    printf("declare i32 @_get(i32)\n\n");

    // generate the code for each function
    struct node_list *function = program->children;
    while((function = function->next) != NULL)
        codegen_function(function->node);

    // generate the entry point which calls main(integer) if it exists
    struct symbol_list *entry = search_symbol(symbol_table, "main");
    if(entry != NULL && entry->node->category == Function)
        printf("define i32 @main() {\n"
               "  %%1 = call i32 @_main(i32 0)\n"
               "  ret i32 %%1\n"
               "}\n");
}
