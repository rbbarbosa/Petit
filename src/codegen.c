#include <stdio.h>
#include "ast.h"

int temporary;

int codegen_expression(struct node *expression);

int codegen_add(struct node *add) {
    /* Exercise 1. implement code generation for addition:
       e1 = codegen_expression(left child expression)
       e2 = codegen_expression(right child expression)
       new_temporary = result of adding e1 + e2
       return new_temporary and post-increment it by 1 */
    int e1 = codegen_expression(getchild(add, 0));
    int e2 = codegen_expression(getchild(add, 1));
    printf("  %%%d = fadd double %%%d, %%%d\n", temporary, e1, e2);
    return temporary++;
}

int codegen_decimal(struct node *decimal) {
    printf("  %%%d = fadd double %s, 0.0\n", temporary, decimal->token);
    return temporary++;
}

/* Exercise 2.2. implement codegen_identifier(...) assuming double is the only type */

int codegen_expression(struct node *expression) {
    int tmp = -1;
    switch(expression->category) {
        /* Exercise 2.2. implement case Identifier */
        case Decimal:
            tmp = codegen_decimal(expression);
            break;
        case Add:
            tmp = codegen_add(expression);
            break;
        default:
            printf("; unimplemented expression\n");
    }
    return tmp;
}

void codegen_print(struct node *print) {
    int tmp = codegen_expression(getchild(print, 0));
    printf("  %%%d = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.fmt_double, i32 0, i32 0), double %%%d)\n", temporary++, tmp);
}

/* Exercise 2.3. implement codegen_assign(...) assuming double is the only type */

/* Exercise 3. implement codegen_loop(...) for generating loop statements */

void codegen_stmtlist(struct node *stmtlist) {
    struct node_list *stmt = stmtlist->children;
    while((stmt = stmt->next) != NULL) {
        switch(stmt->node->category){
            /* Exercise 2.3. implement case Assign */
            case Print:
                codegen_print(stmt->node);
                break;
            /* Exercise 3. implement case Loop */
            default:
                printf("; unimplemented statement\n");
        }
    }
}

void codegen_body(struct node *body) {
    temporary = 1;
    printf("define void @%s() {\n", getchild(body, 0)->token);
    /* Exercise 2.1. generate code to allocate a stack space for each variable in the symbol table, assuming double is the only type to start */
    codegen_stmtlist(getchild(body, 1));
    printf("  ret void\n");
    printf("}\n");
}

void codegen_program(struct node *program) {
    printf("@.fmt_double = private unnamed_addr constant [4 x i8] c\"%%g\\0A\\00\"\n"
           "declare i32 @printf(i8*, ...)\n");

    printf("define i32 @main() {\n"
           "  call void @%s()\n"
           "  ret i32 0\n"
           "}\n", getchild(program, 0)->token);

    codegen_body(program);
}

/* nextup: start directly with simple expressions (with double constants only, disregard integers for now) */
/* then: vardecl for doubles; assignment for doubles; codegen_identifier for doubles -- give a second program that adds variables with immediates and prints the result */

/* Expression nodes (only Id, Nat, Dec) are annotated with the type at the previous stage, use this for deciding whether to round expressions in loops */

