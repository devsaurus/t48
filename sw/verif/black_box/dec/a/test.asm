	;; *******************************************************************
	;; $Id: test.asm,v 1.1.1.1 2004-03-25 22:29:17 arniml Exp $
	;;
	;; Test DEC A.
	;; *******************************************************************

	INCLUDE	"cpu.inc"
	INCLUDE	"pass_fail.inc"

	ORG	0

	;; Start of test
	mov	a, #001H
	dec	a
	jnz	fail

	dec	a
	jb0	ok_0
	jmp	fail

ok_0:	inc	a
	jnz	fail
	
	mov	a, #10100101B
	dec	a
	add	a, #01011101B
	dec	a
	jnz	fail

pass:	PASS

fail:	FAIL
