	;; *******************************************************************
	;; $Id: test.asm,v 1.1.1.1 2004-03-25 22:29:16 arniml Exp $
	;;
	;; Test the JBb instruction on 055H.
	;; *******************************************************************

	INCLUDE	"cpu.inc"
	INCLUDE	"pass_fail.inc"

	ORG	0

	;; Start of test
	mov	a, #055H
	jb0	ok_0
	jmp	fail

ok_0:	jb1	fail

	jb2	ok_2
	jmp	fail

ok_2:	jb3	fail

	jb4	ok_4
	jmp	fail

ok_4:	jb5	fail

	jb6	ok_6
	jmp	fail

ok_6:	jb7	fail

pass:	PASS

fail:	FAIL
