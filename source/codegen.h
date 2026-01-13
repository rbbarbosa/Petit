// This file is part of the Petit compiler.
// SPDX-License-Identifier: BSD-3-Clause

#ifndef _CODEGEN_H
#define _CODEGEN_H

#include "ast.h"

void codegen_program(struct node *program);
int codegen_expression(struct node *expression);

#endif