	;; *******************************************************************
	;; $Id: test.asm,v 1.2 2004-03-29 20:09:47 arniml Exp $
	;;
	;; Test CALL addr with simple program.
	;; *******************************************************************

	INCLUDE	"cpu.inc"
	INCLUDE	"pass_fail.inc"

	ORG	0

	;; Start of test
	mov	a, psw

	clr	c
call1:	call	goon1

	jmp	fail

	ORG	039FH

goon1:	mov	a, psw
	anl	a, #~040H	; mask AC, tested separately with DA
	add	a, #~009H + 1
	jnz	fail

call2:	call	goon2

	jmp	fail

goon2:	clr	c
	mov	a, psw
	anl	a, #~040H	; mask AC, tested separately with DA
	add	a, #~00AH + 1
	jnz	fail

	;; check stack contents
	mov	r0, #008H
	mov	a, @r0
	add	a, #(~(call1+2 & 0FFH) + 1) & 0FFH
	jnz	fail

	inc	r0
	mov	a, @r0
	anl	a, #~040H	; mask AC, tested separately with DA
	add	a, #(~((call1+2) >> 8) + 1) & 0FFH
	jnz	fail

	inc	r0
	mov	a, @r0
	add	a, #(~(call2+2 & 0FFH) + 1) & 0FFH
	jnz	fail

	inc	r0
	mov	a, @r0
	anl	a, #~040H	; mask AC, tested separately with DA
	add	a, #(~((call2+2) >> 8 | 080H) + 1) & 0FFH
	jnz	fail
	
pass:	PASS

fail:	FAIL
