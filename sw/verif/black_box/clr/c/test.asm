	;; *******************************************************************
	;; $Id: test.asm,v 1.1.1.1 2004-03-25 22:29:17 arniml Exp $
	;;
	;; Test CLR C.
	;; *******************************************************************

	INCLUDE	"cpu.inc"
	INCLUDE	"pass_fail.inc"

	ORG	0

	;; Start of test
	jc	fail
	cpl	c
	jnc	fail
	clr	c
	jc	fail
	clr	c
	jc	fail

	mov	a, #0FFH
	add	a, #001H
	jnc	fail
	clr	c
	jc	fail

pass:	PASS

fail:	FAIL
