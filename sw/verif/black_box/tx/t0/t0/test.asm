	;; *******************************************************************
	;; $Id$
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
