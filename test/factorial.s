	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 13, 0
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
	.globl	__factorial                     ; -- Begin function _factorial
	.p2align	2
__factorial:                            ; @_factorial
	.cfi_startproc
; %bb.0:
	cbz	w0, LBB1_2
; %bb.1:                                ; %L1then
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	.cfi_def_cfa_offset 32
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	mov	w19, w0
	sub	w0, w0, #1
	bl	__factorial
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	mul	w0, w19, w0
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB1_2:                                 ; %L1else
	mov	w0, #1
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
.subsections_via_symbols
