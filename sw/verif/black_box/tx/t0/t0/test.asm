	;; *******************************************************************
	;; $Id: test.asm,v 1.1.1.1 2004-03-25 22:29:18 arniml Exp $
	;;
	;; Test J(N)T0 addr.
	;; *******************************************************************

	INCLUDE	"cpu.inc"
	INCLUDE	"pass_fail.inc"

	ORG	0

	;; Start of test
	jnt0	fail
	anl	P1, #0FEH
	jt0	fail
	orl	P1, #001H
	jt0	pass

fail:	FAIL

pass:	PASS
