	;; *******************************************************************
	;; $Id: test.asm,v 1.1.1.1 2004-03-25 22:29:18 arniml Exp $
	;;
	;; Test Timer.
	;; *******************************************************************

	INCLUDE	"cpu.inc"
	INCLUDE	"pass_fail.inc"

	ORG	0

	;; Start of test
	mov	a, #0F8H
	mov	t, a

	strt	t
	jtf	fail

	mov	r0, #000H
poll1:	jtf	goon1
	djnz	r0, poll1
	jmp	fail

goon1:	mov	a, t
	jnz	fail
	mov	r0, #000H
poll2:	mov	a, t
	add	a, #0FBH
	jz	goon2
	djnz	r0, poll2

goon2:	stop	tcnt
	clr	a
	mov	t, a
	strt	t

	mov	a, t
	jnz	fail

	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop

	mov	a, t
	dec	a
	jnz	fail

	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop

	mov	a, t
	dec	a
	dec	a
	jnz	fail

pass:	PASS

fail:	FAIL
