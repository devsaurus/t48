	;; *******************************************************************
	;; $Id: test.asm,v 1.1.1.1 2004-03-25 22:29:18 arniml Exp $
	;;
	;; Test Timer Interrupt.
	;; *******************************************************************

	INCLUDE	"cpu.inc"
	INCLUDE	"pass_fail.inc"

	ORG	0
	jmp	start
	nop
	jmp	fail
	jmp	fail
	jmp	timer_int
	jmp	fail

	;; Start of test
start:	mov	a, #0F8H
	mov	t, a
	clr	a
	mov	r0, a
	mov	r1, a

	en	tcnti
	jtf	fail

	strt	t

loop:	mov	a, r0
	jnz	pass
	djnz	r1, loop

fail:	FAIL

pass:	PASS


timer_int:
	mov	r0, #0FFH
	retr
