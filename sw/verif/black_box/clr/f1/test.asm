	;; *******************************************************************
	;; $Id: test.asm,v 1.1.1.1 2004-03-25 22:29:17 arniml Exp $
	;;
	;; Test CLR F1.
	;; *******************************************************************

	INCLUDE	"cpu.inc"
	INCLUDE	"pass_fail.inc"

	ORG	0

	;; Start of test
	jf1	fail
	cpl	f1
	jf1	ok_1
	jmp	fail

ok_1:	clr	f1
	jf1	fail

pass:	PASS

fail:	FAIL
