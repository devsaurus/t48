	;; *******************************************************************
	;; $Id: test.asm,v 1.1.1.1 2004-03-25 22:29:18 arniml Exp $
	;;
	;; Test XRL A, data.
	;; *******************************************************************

	INCLUDE	"cpu.inc"
	INCLUDE	"pass_fail.inc"

	ORG	0

	;; Start of test
	clr	a
	xrl	a, #0FFH
	jz	fail
	xrl	a, #0FFH
	jnz	fail

	clr	a
	xrl	a, #055H
	add	a, #0ABH
	jnz	fail

	clr	a
	xrl	a, #023H
	xrl	a, #0A9H
	add	a, #076H
	jnz	fail

pass:	PASS

fail:	FAIL
