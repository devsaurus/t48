	;; *******************************************************************
	;; $Id: test.asm,v 1.1.1.1 2004-03-25 22:29:17 arniml Exp $
	;;
	;; Test CPL C.
	;; *******************************************************************

	INCLUDE	"cpu.inc"
	INCLUDE	"pass_fail.inc"

	ORG	0

	;; Start of test
	jc	fail

	cpl	c
	jnc	fail

	mov	a, #0FEH
	add	a, #001H
	jc	fail
	cpl	c
	jnc	fail

	add	a, #001H
	jnc	fail
	cpl	c
	jc	fail

pass:	PASS

fail:	FAIL
