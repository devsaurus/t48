	;; *******************************************************************
	;; $Id: test.asm,v 1.1.1.1 2004-03-25 22:29:18 arniml Exp $
	;;
	;; Test IN A, Pp.
	;; *******************************************************************

	INCLUDE	"cpu.inc"
	INCLUDE	"pass_fail.inc"

	ORG	0

	;; Start of test
	mov	a, #055H
	outl	p1, a
	mov	a, #0AAH
	outl	p2, a

	clr	a
	in	a, p1
	add	a, #0ABH
	jnz	fail

	in	a, p2
	add	a, #056H
	jnz	fail

pass:	PASS

fail:	FAIL
