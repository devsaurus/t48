	;; *******************************************************************
	;; $Id: test.asm,v 1.1.1.1 2004-03-25 22:29:16 arniml Exp $
	;;
	;; Test MOV A, Rr for RB0 with 0x00.
	;; *******************************************************************

	INCLUDE	"cpu.inc"
	INCLUDE	"pass_fail.inc"

	ORG	0

	;; Start of test
	mov	a, #0x55
	mov	r0, #0x00
	mov	r1, #0xff
	mov	r2, #0xff
	mov	r3, #0xff
	mov	r4, #0xff
	mov	r5, #0xff
	mov	r6, #0xff
	mov	r7, #0xff

	mov	a, r0
	jnz	fail

	mov	r1, #0x00
	mov	r0, #0xff
	mov	a, r1
	jnz	fail

	mov	r2, #0x00
	mov	r1, #0xff
	mov	a, r2
	jnz	fail

	mov	r3, #0x00
	mov	r2, #0xff
	mov	a, r3
	jnz	fail

	mov	r4, #0x00
	mov	r3, #0xff
	mov	a, r4
	jnz	fail

	mov	r5, #0x00
	mov	r4, #0xff
	mov	a, r5
	jnz	fail

	mov	r6, #0x00
	mov	r5, #0xff
	mov	a, r6
	jnz	fail

	mov	r7, #0x00
	mov	r6, #0xff
	mov	a, r7
	jnz	fail

pass:	PASS

fail:	FAIL
