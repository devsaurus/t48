	;; *******************************************************************
	;; $Id: test.asm,v 1.2 2004-05-17 14:42:09 arniml Exp $
	;;
	;; Test MOVX A, @ Rr for RB0.
	;; *******************************************************************

	INCLUDE	"cpu.inc"
	INCLUDE	"pass_fail.inc"

	ORG	0

	;; Start of test
	mov	r0, #0FEH
fill_loop1:
	mov	a, r0
	movx	@r0, a
	djnz	r0, fill_loop1

	;; check memory
	mov	a, r0
	jnz	fail
	mov	r0, #0FEH
	mov	r1, #002H
check_loop1:
	clr	a
	movx	a, @r1
	add	a, r0
	jnz	fail
	inc	r1
	dec	r0
	mov	a, r0
	dec	a
	jnz	check_loop1



	mov	r1, #0FEH
	mov	a, #002H
fill_loop2:
	movx	@r1, a
	inc	a
	djnz	r1, fill_loop2

	;; check memory
	mov	a, r1
	jnz	fail
	mov	r0, #0FEH
check_loop2:
	clr	a
	movx	a, @r0
	add	a, r0
	jnz	fail
	dec	r0
	mov	a, r0
	dec	a
	jnz	check_loop2

pass:	PASS

fail:	FAIL
