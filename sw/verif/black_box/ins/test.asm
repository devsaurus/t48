	;; *******************************************************************
	;; $Id: test.asm,v 1.1.1.1 2004-03-25 22:29:18 arniml Exp $
	;;
	;; Test INS A, BUS.
	;; *******************************************************************

	INCLUDE	"cpu.inc"
	INCLUDE	"pass_fail.inc"

	ORG	0

	;; Start of test
	mov	a, #055H
	outl	bus, a

	clr	a
	ins	a, bus
	add	a, #0ABH
	jnz	fail

	mov	a, #0AAH
	outl	bus, a

	clr	a
	ins	a, bus
	add	a, #056H
	jnz	fail

pass:	PASS

fail:	FAIL
