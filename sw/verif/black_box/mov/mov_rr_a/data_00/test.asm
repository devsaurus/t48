	;; *******************************************************************
	;; $Id: test.asm,v 1.1.1.1 2004-03-25 22:29:16 arniml Exp $
	;;
	;; Test MOV Rr, A for RB0 with 0x00.
	;; *******************************************************************

	INCLUDE	"cpu.inc"
	INCLUDE	"pass_fail.inc"

	ORG	0

	;; Start of test
	mov	a, #0x00
	mov	r0, a
	mov	a, #0xff
	mov	r1, a
	mov	r2, a
	mov	r3, a
	mov	r4, a
	mov	r5, a
	mov	r6, a
	mov	r7, a

	mov	a, r0
	jnz	fail

	mov	a, #0x00
	mov	r1, a
	mov	a, #0xff
	mov	r0, a
	mov	a, r1
	jnz	fail

	mov	a, #0x00
	mov	r2, a
	mov	a, #0xff
	mov	r1, a
	mov	a, r2
	jnz	fail

	mov	a, #0x00
	mov	r3, a
	mov	a, #0xff
	mov	r2, a
	mov	a, r3
	jnz	fail

	mov	a, #0x00
	mov	r4, a
	mov	a, #0xff
	mov	r3, a
	mov	a, r4
	jnz	fail

	mov	a, #0x00
	mov	r5, a
	mov	a, #0xff
	mov	r4, a
	mov	a, r5
	jnz	fail

	mov	a, #0x00
	mov	r6, a
	mov	a, #0xff
	mov	r5, a
	mov	a, r6
	jnz	fail

	mov	a, #0x00
	mov	r7, a
	mov	a, #0xff
	mov	r6, a
	mov	a, r7
	jnz	fail

pass:	PASS

fail:	FAIL
