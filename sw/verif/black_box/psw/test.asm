	;; *******************************************************************
	;; $Id: test.asm,v 1.1.1.1 2004-03-25 22:29:17 arniml Exp $
	;;
	;; Test several commands related to PSW.
	;; *******************************************************************

	INCLUDE	"cpu.inc"
	INCLUDE	"pass_fail.inc"

	ORG	0

	;; Start of test
	mov	a, psw
	anl	a, #0F7H
	jnz	fail

	dec	a
	mov	psw, a
	mov	a, psw
	inc	a
	jnz	fail

	mov	psw, a
	mov	a, psw
	anl	a, #0F7H
	jnz	fail

	cpl	f0
	jf0	ok_1
	jmp	fail
ok_1:	mov	a, psw
	add	a, #(~028H + 1) & 0FFH
	jnz	fail

	clr	f0
	jnc	fail
	mov	a, psw
	add	a, #(~088H + 1) & 0FFH
	jnz	fail

	clr	c
	jc	fail
	sel	rb1
	mov	a, psw
	add	a, #(~018H + 1) & 0FFH
	jnz	fail

	cpl	c
	jc	fail
	sel	rb0
	mov	a, psw
	add	a, #(~08H + 1) & 0FFH
	jnz	fail

pass:	PASS

fail:	FAIL
