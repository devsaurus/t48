	;; *******************************************************************
	;; $Id: test.asm,v 1.1.1.1 2004-03-25 22:29:18 arniml Exp $
	;;
	;; Test J(N)T1 addr.
	;; *******************************************************************

	INCLUDE	"cpu.inc"
	INCLUDE	"pass_fail.inc"

	ORG	0

	;; Start of test
	jnt1	fail
	anl	P1, #0FDH
	jt1	fail
	orl	P1, #002H
	jt1	pass

fail:	FAIL

pass:	PASS
