	;; *******************************************************************
	;; $Id: test.asm,v 1.2 2004-05-16 16:25:46 arniml Exp $
	;;
	;; Test Counter.
	;; *******************************************************************

	INCLUDE	"cpu.inc"
	INCLUDE	"pass_fail.inc"

	ORG	0

	;; Start of test
	mov	a, #0FEH
	mov	t, a

	strt	cnt
	jtf	fail

	;; apply falling edge on T1
	anl	P1, #0FDH
	jtf	fail
	mov	a, t
	cpl	a
	add	a, #0FFH
	cpl	a
	jnz	fail

	;; apply rising edge on T1
	orl	P1, #002H
	jtf	fail

	;; apply falling edge on T1
	anl	P1, #0FDH
	jtf	goon
	jmp	fail
goon:	jtf	fail
	mov	a, t
	jnz	fail

	;; apply rising edge on T1
	orl	P1, #002H
	jtf	fail

	;; apply falling edge on T1
	anl	P1, #0FDH
	jtf	fail
	mov	a, t
	dec	a
	jnz	fail

	;; check inactivity of counter
	stop	tcnt
	mov	a, #0FFH
	mov	t, a

	;; apply rising edge on T1
	orl	P1, #002H
	jtf	fail
	;; apply falling edge on T1
	anl	P1, #0FDH
	jtf	fail
	;; apply rising edge on T1
	orl	P1, #002H
	jtf	fail
	;; apply falling edge on T1
	anl	P1, #0FDH
	jtf	fail

	strt	cnt
	;; apply rising edge on T1
	orl	P1, #002H
	jtf	fail
	;; apply falling edge on T1
	anl	P1, #0FDH
	jtf	goon2
	jmp	fail

goon2:

pass:	PASS

fail:	FAIL
