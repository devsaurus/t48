	;; *******************************************************************
	;; $Id: test.asm,v 1.1.1.1 2004-03-25 22:29:17 arniml Exp $
	;;
	;; Test CPL A.
	;; *******************************************************************

	INCLUDE	"cpu.inc"
	INCLUDE	"pass_fail.inc"

	ORG	0

	;; Start of test
	mov	a, #0FFH
	cpl	a
	jnz	fail

	cpl	a
	inc	a
	jnz	fail

	mov	a, #055H
	cpl	a
	add	a, #01010110B
	jnz	fail

pass:	PASS

fail:	FAIL
