	;; *******************************************************************
	;; $Id: test.asm,v 1.1.1.1 2004-03-25 22:29:17 arniml Exp $
	;;
	;; Test JNC instruction.
	;; *******************************************************************

	INCLUDE	"cpu.inc"
	INCLUDE	"pass_fail.inc"

	ORG	0

	;; Start of test
	jnc	ok_1
	jmp	fail

ok_1:	mov	a, #0FFH
	add	a, #001H
	jnc	fail

pass:	PASS

fail:	FAIL
