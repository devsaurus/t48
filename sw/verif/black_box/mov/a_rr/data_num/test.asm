	;; *******************************************************************
	;; $Id: test.asm,v 1.1.1.1 2004-03-25 22:29:16 arniml Exp $
	;;
	;; Test MOV A, Rr for RB0 with 2*r.
	;; *******************************************************************

	INCLUDE	"cpu.inc"
	INCLUDE	"pass_fail.inc"

	ORG	0

	;; Start of test
	mov	a, #0x00
	mov	r0, #0xfe
	mov	r1, #0xfd
	mov	r2, #0xfb
	mov	r3, #0xf7
	mov	r4, #0xef
	mov	r5, #0xdf
	mov	r6, #0xbf
	mov	r7, #0x7f

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
