	;; *******************************************************************
	;; $Id: test.asm,v 1.1.1.1 2004-03-25 22:29:18 arniml Exp $
	;;
	;; Test MOVX A, @ Rr for RB0.
	;; *******************************************************************

	INCLUDE	"cpu.inc"
	INCLUDE	"pass_fail.inc"

	ORG	0

	;; Start of test
	mov	r0, #0FFH
fill_loop1:
	mov	a, r0
	movx	@r0, a
	djnz	r0, fill_loop1

	;; check memory
	mov	a, r0
	jnz	fail
	mov	r0, #0FFH
	mov	r1, #001H
check_loop1:
	movx	a, @r1
	add	a, r0
	jnz	fail
	dec	r0
	inc	r1
	mov	a, r1
	jnz	check_loop1



	mov	r1, #0FFH
	mov	a, #001H
fill_loop2:
	movx	@r1, a
	inc	a
	djnz	r1, fill_loop2

	;; check memory
	mov	a, r0
	jnz	fail
	mov	r0, #0FFH
check_loop2:
	movx	a, @r0
	add	a, r0
	jnz	fail
	djnz	r0, check_loop2

pass:	PASS

fail:	FAIL
