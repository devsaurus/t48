	;; *******************************************************************
	;; $Id: test.asm,v 1.1.1.1 2004-03-25 22:29:17 arniml Exp $
	;;
	;; Test a simple jump to interrupt.
	;; *******************************************************************

	INCLUDE	"cpu.inc"
	INCLUDE	"pass_fail.inc"

	ORG	0

	;; Start of test
	jmp	start_user


	ORG	3
	jmp	pass


	ORG	010H
start_user:
	en	i
	mov	r0, #080H
loop:	djnz	r0, loop

fail:	FAIL

pass:	PASS
