	;; *******************************************************************
	;; $Id: test.asm,v 1.1.1.1 2004-03-25 22:29:18 arniml Exp $
	;;
	;; Test Program Memory bank selector with interrupts.
	;; *******************************************************************

	INCLUDE	"cpu.inc"
	INCLUDE	"pass_fail.inc"

	ORG	0
	jmp	start
	ORG	3
	sel	mb1
	jmp	interrupt & 07FFH

	ORG	7
	jmp	fail

	;; Start of test
start:
	mov	r0, #000H
	en	i
poll:	jf1	pass
	djnz	r0, poll
	jmp	fail

pass:	PASS

fail:	FAIL


	ORG	0A32H
	jmp	fail_hi
interrupt:
	cpl	f1
	sel	mb1
	retr


fail_hi:
	FAIL
