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
	.globl	__gcd                           ; -- Begin function _gcd
	.p2align	2
__gcd:                                  ; @_gcd
	.cfi_startproc
; %bb.0:
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	.cfi_def_cfa_offset 32
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	mov	w19, w1
	mov	w20, w0
	bl	__mod
	cbz	w0, LBB1_2
; %bb.1:                                ; %L1then
	mov	w0, w20
	mov	w1, w19
	bl	__mod
	mov	w1, w0
	mov	w0, w19
	bl	__gcd
	mov	w19, w0
LBB1_2:                                 ; %L1end
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	mov	w0, w19
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
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
	mov	w0, #366
	mov	w1, #60
	bl	__gcd
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
