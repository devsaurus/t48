	;; *******************************************************************
	;; $Id: test.asm,v 1.1.1.1 2004-03-25 22:29:16 arniml Exp $
	;;
	;; Test the JBb instruction on 0AAH.
	;; *******************************************************************

	INCLUDE	"cpu.inc"
	INCLUDE	"pass_fail.inc"

	ORG	0

	;; Start of test
	mov	a, #0AAH
	jb0	fail

	jb1	ok_1
	jmp	fail

ok_1:	jb2	fail

	jb3	ok_3
	jmp	fail

ok_3:	jb4	fail

	jb5	ok_5
	jmp	fail

ok_5:	jb6	fail

	jb7	pass

fail:	FAIL

pass:	PASS
