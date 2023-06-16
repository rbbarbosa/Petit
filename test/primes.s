	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 13, 0
	.globl	__mod                           ; -- Begin function _mod
	.p2align	2
__mod:                                  ; @_mod
	.cfi_startproc
; %bb.0:
	sdiv	w8, w0, w1
	msub	w0, w8, w1, w0
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	__prime                         ; -- Begin function _prime
	.p2align	2
__prime:                                ; @_prime
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
	cmp	w0, #1
	b.eq	LBB1_4
; %bb.1:                                ; %L1then
	mov	w20, w1
	mov	w19, w0
	sub	x21, sp, #16
	mov	sp, x21
	cmp	w0, w1
	b.eq	LBB1_5
; %bb.2:                                ; %L6then
	sub	x22, sp, #16
	mov	sp, x22
	mov	w0, w19
	mov	w1, w20
	bl	__mod
	cbz	w0, LBB1_6
; %bb.3:                                ; %L11then
	add	w1, w20, #1
	mov	w0, w19
	bl	__prime
	str	w0, [x22]
	mov	w8, w0
	b	LBB1_7
LBB1_4:                                 ; %L1else
	stur	wzr, [x29, #-36]
	b	LBB1_8
LBB1_5:                                 ; %L6else
	mov	w8, #1
	b	LBB1_7
LBB1_6:                                 ; %L11else
	str	wzr, [x22]
	mov	w8, wzr
LBB1_7:                                 ; %L6end
	str	w8, [x21]
	mov	w8, w8
	stur	w8, [x29, #-36]
LBB1_8:                                 ; %L1end
	ldur	w0, [x29, #-36]
	sub	sp, x29, #32
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	__list                          ; -- Begin function _list
	.p2align	2
__list:                                 ; @_list
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
	cbz	w0, LBB2_4
; %bb.1:                                ; %L1then
	mov	w19, w0
	sub	x22, sp, #16
	mov	sp, x22
	mov	w1, #2
	bl	__prime
	mov	w21, w0
	sub	w0, w19, #1
	bl	__list
	mov	w20, w0
	cbz	w21, LBB2_3
; %bb.2:                                ; %L4then
	mov	w0, w19
	bl	__write
LBB2_3:                                 ; %L4else
	mov	w8, w20
	str	w20, [x22]
	stur	w8, [x29, #-36]
	b	LBB2_5
LBB2_4:                                 ; %L1else
	stur	wzr, [x29, #-36]
LBB2_5:                                 ; %L1end
	ldur	w0, [x29, #-36]
	sub	sp, x29, #32
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
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
	mov	w0, #100
	bl	__list
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
