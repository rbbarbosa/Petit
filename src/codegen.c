#include <stdio.h>
#include "ast.h"
#include "semantics.h"

int temporary;

extern struct symbol_list *symbol_table;

int codegen_expression(struct node *expression);

int codegen_add(struct node *add) {
    /* Exercise 1. implement code generation for addition:
       e1 = codegen_expression(left child)
       e2 = codegen_expression(right child)
       new_temporary = result of adding e1 + e2
       return new_temporary and post-increment it by 1 */
    int e1 = codegen_expression(getchild(add, 0));
    int e2 = codegen_expression(getchild(add, 1));
    printf("  %%%d = fadd double %%%d, %%%d\n", temporary, e1, e2);
    return temporary++;
}

int codegen_sub(struct node *sub) {
    int e1 = codegen_expression(getchild(sub, 0));
    int e2 = codegen_expression(getchild(sub, 1));
    printf("  %%%d = fsub double %%%d, %%%d\n", temporary, e1, e2);
    return temporary++;
}

int codegen_mul(struct node *mul) {
    int e1 = codegen_expression(getchild(mul, 0));
    int e2 = codegen_expression(getchild(mul, 1));
    printf("  %%%d = fmul double %%%d, %%%d\n", temporary, e1, e2);
    return temporary++;
}

int codegen_div(struct node *div) {
    int e1 = codegen_expression(getchild(div, 0));
    int e2 = codegen_expression(getchild(div, 1));
    printf("  %%%d = fdiv double %%%d, %%%d\n", temporary, e1, e2);
    return temporary++;
}

int codegen_decimal(struct node *decimal) {
    printf("  %%%d = fadd double %s, 0.0\n", temporary, decimal->token);
    return temporary++;
}

/* Exercise 3.3. implement codegen_identifier(...) assuming double is the only type */
int codegen_identifier(struct node *identifier) {
    printf("  %%%d = load double, double* %%%s\n", temporary, identifier->token);
    return temporary++;
}

int codegen_expression(struct node *expression) {
    int tmp = -1;
    switch(expression->category) {
        /* Exercise 3.3. implement case Identifier */
        case Identifier:
            tmp = codegen_identifier(expression);
            break;
        case Decimal:
            tmp = codegen_decimal(expression);
            break;
        case Add:
            tmp = codegen_add(expression);
            break;
        /* Exercise 2. implement support for subtraction, multiplication and division */
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

void codegen_print(struct node *print) {
    int tmp = codegen_expression(getchild(print, 0));
    printf("  %%%d = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.fmt_double, i32 0, i32 0), double %%%d)\n", temporary++, tmp);
}

/* Exercise 3.2. implement codegen_assign(...) assuming double is the only type */
void codegen_assign(struct node *assign) {
    int e = codegen_expression(getchild(assign, 1));
    printf("  store double %%%d, double* %%%s\n", e, getchild(assign, 0)->token);
}

void codegen_varstmtlist(struct node *varstmtlist);

/* Exercise 4. implement codegen_loop(...) for generating loop statements */
void codegen_loop(struct node *loop) {
    int loop_number = temporary;
    printf("  br label %%L%dentry\n"
           "L%dentry:\n", loop_number, loop_number);
    int e = codegen_expression(getchild(loop, 0));
    printf("  %%%d = fptosi double %%%d to i32\n", temporary, e);   // bitcast if i32
    printf("  br label %%L%dtest\n"
           "L%dtest:\n"
           "  %%%d = phi i32 [0, %%L%dentry], [%%%d, %%L%dbody]\n"
           "  %%%d = add i32 %%%d, 1\n",
           loop_number, loop_number, temporary+1, loop_number, temporary+2, loop_number, temporary+2, temporary+1);
    printf("  %%%d = icmp sge i32 %%%d, %%%d\n"
           "  br i1 %%%d, label %%L%dend, label %%L%dbody\n"
           "L%dbody:\n",
           temporary+3, temporary+1, temporary, temporary+3, loop_number, loop_number, loop_number);
    temporary += 4;
    codegen_varstmtlist(getchild(loop, 1));
    printf("  br label %%L%dtest\n"
           "L%dend:\n", loop_number, loop_number);
}

void codegen_varstmtlist(struct node *varstmtlist) {
    struct node_list *child = varstmtlist->children;
    while((child = child->next) != NULL) {
        switch(child->node->category) {
            /* Exercise 3.1. generate code to allocate a stack space for each variable in the symbol table, assuming double is the only type to start */
            case Variable:
                printf("  %%%s = alloca double\n", getchild(child->node, 1)->token);
                break;
            /* Exercise 3.2. implement case Assign */
            case Assign:
                codegen_assign(child->node);
                break;
            case Print:
                codegen_print(child->node);
                break;
            /* Exercise 4. implement case Loop */
            case Loop:
                codegen_loop(child->node);
                break;
            default:
                break;
        }
    }
}

void codegen_body(struct node *body) {
    temporary = 1;
    printf("define void @%s() {\n", getchild(body, 0)->token);
    codegen_varstmtlist(getchild(body, 1));
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
