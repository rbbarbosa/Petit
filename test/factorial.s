	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 13, 0
	.globl	__factorial                     ; -- Begin function _factorial
	.p2align	2
__factorial:                            ; @_factorial
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
	cbz	w0, LBB0_2
; %bb.1:                                ; %L1then
	mov	w19, w0
	sub	w0, w0, #1
	bl	__factorial
	mul	w8, w19, w0
	b	LBB0_3
LBB0_2:                                 ; %L1else
	mov	w8, #1
LBB0_3:                                 ; %L1end
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	str	w8, [sp, #12]
	mov	w0, w8
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
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
	mov	w0, wzr
	bl	__read
	bl	__factorial
	bl	__write
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
