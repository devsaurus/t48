	;; *******************************************************************
	;; $Id$
	;;
	;; Test CPL F1.
	;; *******************************************************************

	INCLUDE	"cpu.inc"
	INCLUDE	"pass_fail.inc"

	ORG	0

	;; Start of test
	jf1	fail
	cpl	f1
	jf1	ok_1
	jmp	fail

ok_1:	cpl	f1
	jf1	fail

pass:	PASS

fail:	FAIL
