	;; *******************************************************************
	;; $Id: test.asm,v 1.1.1.1 2004-03-25 22:29:18 arniml Exp $
	;;
	;; Test ORL A, data.
	;; *******************************************************************

	INCLUDE	"cpu.inc"
	INCLUDE	"pass_fail.inc"

	ORG	0

	;; Start of test
	clr	a
	orl	a, #0FFH
	jz	fail
	orl	a, #0FFH
	jz	fail

	clr	a
	orl	a, #055H
	add	a, #0ABH
	jnz	fail

	clr	a
	orl	a, #023H
	orl	a, #088H
	add	a, #055H
	jnz	fail

pass:	PASS

fail:	FAIL
