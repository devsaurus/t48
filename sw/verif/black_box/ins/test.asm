	;; *******************************************************************
	;; $Id: test.asm,v 1.2 2004-10-25 19:33:13 arniml Exp $
	;;
	;; Test INS A, BUS.
	;; *******************************************************************

	INCLUDE	"cpu.inc"
	INCLUDE	"pass_fail.inc"

	ORG	0

	;; Start of test

	;; deselect external memory
	mov	r0, #0FFH
	clr	a
	movx	@r0, a

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
