	;; *******************************************************************
	;; $Id: test.asm,v 1.1.1.1 2004-03-25 22:29:16 arniml Exp $
	;;
	;; Test MOV Rr, A for RB0 with 2*r.
	;; *******************************************************************

	INCLUDE	"cpu.inc"
	INCLUDE	"pass_fail.inc"

	ORG	0

	;; Start of test
	mov	a, #0xfe
	mov	r0, a
	mov	a, #0xfd
	mov	r1, a
	mov	a, #0xfb
	mov	r2, a
	mov	a, #0xf7
	mov	r3, a
	mov	a, #0xef
	mov	r4, a
	mov	a, #0xdf
	mov	r5, a
	mov	a, #0xbf
	mov	r6, a
	mov	a, #0x7f
	mov	r7, a

	mov	a, #0x00

	mov	a, r0
	jz	fail
	jb0	fail

	mov	a, r1
	jb1	fail

	mov	a, r2
	jb2	fail

	mov	a, r3
	jb3	fail

	mov	a, r4
	jb4	fail

	mov	a, r5
	jb5	fail

	mov	a, r6
	jb6	fail

	mov	a, r7
	jb7	fail

pass:	PASS

fail:	FAIL
