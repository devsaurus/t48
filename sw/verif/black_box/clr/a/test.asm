	;; *******************************************************************
	;; $Id: test.asm,v 1.1.1.1 2004-03-25 22:29:17 arniml Exp $
	;;
	;; Test CLR A.
	;; *******************************************************************

	INCLUDE	"cpu.inc"
	INCLUDE	"pass_fail.inc"

	ORG	0

	;; Start of test
	mov	a, #0FFH
	jz	fail
	clr	a
	jnz	fail

	inc	a
	jb0	ok_1
	jmp	fail

ok_1:	add	a, #0FFH
	jnz	fail

	add	a, #010H
	clr	a
	dec	a
	add	a, #001H
	jnz	fail

pass:	PASS

fail:	FAIL
