	;; *******************************************************************
	;; $Id: test.asm,v 1.1.1.1 2004-03-25 22:29:17 arniml Exp $
	;;
	;; Test OUTL Pp, A
	;; *******************************************************************

	INCLUDE	"cpu.inc"
	INCLUDE	"pass_fail.inc"

	ORG	0

	;; Start of test
	mov	a, #055H
	outl	p1, a
	mov	a, #0AAH
	outl	p2, a

pass:	PASS

fail:	FAIL
