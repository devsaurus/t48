	;; *******************************************************************
	;; $Id: test.asm,v 1.1.1.1 2004-03-25 22:29:17 arniml Exp $
	;;
	;; Test CLR F0.
	;; *******************************************************************

	INCLUDE	"cpu.inc"
	INCLUDE	"pass_fail.inc"

	ORG	0

	;; Start of test
	jf0	fail
	cpl	f0
	jf0	ok_1
	jmp	fail

ok_1:	clr	f0
	jf0	fail

pass:	PASS

fail:	FAIL
