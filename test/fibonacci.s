	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 13, 0
	.globl	__fib                           ; -- Begin function _fib
	.p2align	2
__fib:                                  ; @_fib
	.cfi_startproc
; %bb.0:
	stp	x22, x21, [sp, #-48]!           ; 16-byte Folded Spill
	stp	x20, x19, [sp, #16]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	sub	sp, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	subs	w19, w0, #1
	b.eq	LBB0_3
; %bb.1:                                ; %L1then
	sub	x21, sp, #16
	mov	sp, x21
	subs	w0, w0, #2
	b.eq	LBB0_4
; %bb.2:                                ; %L6then
	bl	__fib
	mov	w20, w0
	mov	w0, w19
	bl	__fib
	add	w8, w20, w0
	b	LBB0_5
LBB0_3:                                 ; %L1else
	mov	w8, #1
	b	LBB0_6
LBB0_4:                                 ; %L6else
	mov	w8, #1
LBB0_5:                                 ; %L6end
	str	w8, [x21]
	mov	w8, w8
LBB0_6:                                 ; %L1end
	stur	w8, [x29, #-36]
	mov	w0, w8
	sub	sp, x29, #32
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	__seq                           ; -- Begin function _seq
	.p2align	2
__seq:                                  ; @_seq
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #48
	stp	x20, x19, [sp, #16]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	.cfi_def_cfa_offset 48
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	cbz	w0, LBB1_2
; %bb.1:                                ; %L1then
	mov	w19, w0
	sub	w0, w0, #1
	bl	__seq
	mov	w20, w0
	mov	w0, w19
	bl	__fib
	bl	__write
	str	w20, [sp, #12]
	b	LBB1_3
LBB1_2:                                 ; %L1else
	str	wzr, [sp, #12]
LBB1_3:                                 ; %L1end
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldr	w0, [sp, #12]
	add	sp, sp, #48
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	__main                          ; -- Begin function _main
	.p2align	2
__main:                                 ; @_main
	.cfi_startproc
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	.cfi_def_cfa_offset 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	mov	w0, #20
	bl	__seq
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_main                           ; -- Begin function main
	.p2align	2
_main:                                  ; @main
	.cfi_startproc
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	.cfi_def_cfa_offset 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	mov	w0, wzr
	bl	__main
	mov	w0, wzr
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
.subsections_via_symbols
