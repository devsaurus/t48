	;; *******************************************************************
	;; $Id: test.asm,v 1.2 2004-03-26 22:34:14 arniml Exp $
	;;
	;; Test JZ instruction.
	;; *******************************************************************

	INCLUDE	"cpu.inc"
	INCLUDE	"pass_fail.inc"

	ORG	0

	;; Start of test
	mov	a, #000H
	jz	ok_0
	jmp	fail

ok_0:	mov	a, #001H
	jz	fail

	mov	a, #002H
	jz	fail

	mov	a, #004H
	jz	fail

	mov	a, #008H
	jz	fail

	mov	a, #010H
	jz	fail

	mov	a, #020H
	jz	fail

	mov	a, #040H
	jz	fail

	mov	a, #080H
	jz	fail

pass:	PASS

fail:	FAIL
