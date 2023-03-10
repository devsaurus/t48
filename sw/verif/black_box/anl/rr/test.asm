	;; *******************************************************************
	;; Test ANL A, Rr for RB0 and RB1.
	;; *******************************************************************

	INCLUDE	"cpu.inc"
	INCLUDE	"pass_fail.inc"

	ORG	0

	;; Start of test

	;; fill RB0
	call	fill

	;; check RB0
	call	check

	;; fill RB1
	sel	rb1
	call	fill
	sel	rb0

	;; clear RB0
	call	clr_rb0

	;; check RB1
	sel	rb1
	call	check

        ;; check RB0 for all 0
	mov	r0, #000H
	mov	r1, #008H
chk0_loop:
	mov	a, @r0
	jnz	fail
	inc	r0
	djnz	r1, chk0_loop

pass:	PASS

fail:	FAIL


	ORG	0300H

fill:	mov	a, #0FEH
	mov	r0, a
	mov	a, #0FDH
	mov	r1, a
	mov	a, #0FBH
	mov	r2, a
	mov	a, #0F7H
	mov	r3, a
	mov	a, #0EFH
	mov	r4, a
	mov	a, #0DFH
	mov	r5, a
	mov	a, #0BFH
	mov	r6, a
	mov	a, #07FH
	mov	r7, a
	ret

clr_rb0:
	mov	r0, #007H
	clr	a
clr_loop:
	mov	@r0, a
	djnz	r0, clr_loop
	ret

check:	mov	a, #(1 << 0)
	anl	a, r0
	jnz	fail_p3
	mov	a, #0FFH
	anl	a, r0
	add	a, #(~(0FFH - (1 << 0)) + 1) & 0FFH
	jnz	fail_p3

	mov	a, #(1 << 1)
	anl	a, r1
	jnz	fail_p3
	mov	a, #0FFH
	anl	a, r1
	add	a, #(~(0FFH - (1 << 1)) + 1) & 0FFH
	jnz	fail_p3

	mov	a, #(1 << 2)
	anl	a, r2
	jnz	fail_p3
	mov	a, #0FFH
	anl	a, r2
	add	a, #(~(0FFH - (1 << 2)) + 1) & 0FFH
	jnz	fail_p3

	mov	a, #(1 << 3)
	anl	a, r3
	jnz	fail_p3
	mov	a, #0FFH
	anl	a, r3
	add	a, #(~(0FFH - (1 << 3)) + 1) & 0FFH
	jnz	fail_p3

	mov	a, #(1 << 4)
	anl	a, r4
	jnz	fail_p3
	mov	a, #0FFH
	anl	a, r4
	add	a, #(~(0FFH - (1 << 4)) + 1) & 0FFH
	jnz	fail_p3

	mov	a, #(1 << 5)
	anl	a, r5
	jnz	fail_p3
	mov	a, #0FFH
	anl	a, r5
	add	a, #(~(0FFH - (1 << 5)) + 1) & 0FFH
	jnz	fail_p3

	mov	a, #(1 << 6)
	anl	a, r6
	jnz	fail_p3
	mov	a, #0FFH
	anl	a, r6
	add	a, #(~(0FFH - (1 << 6)) + 1) & 0FFH
	jnz	fail_p3

	mov	a, #(1 << 7)
	anl	a, r7
	jnz	fail_p3
	mov	a, #0FFH
	anl	a, r7
	add	a, #(~(0FFH - (1 << 7)) + 1) & 0FFH
	jnz	fail_p3
	ret


fail_p3:	FAIL
