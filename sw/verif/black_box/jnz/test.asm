	;; *******************************************************************
	;; $Id: test.asm,v 1.1.1.1 2004-03-25 22:29:16 arniml Exp $
	;;
	;; Test JNZ instruction.
	;; *******************************************************************

	INCLUDE	"cpu.inc"
	INCLUDE	"pass_fail.inc"

	ORG	0

	;; Start of test
	mov	a, #0x00
	jnz	fail

	mov	a, #0x01
	jnz	ok_01
	jmp	fail

ok_01:	mov	a, #0x02
	jnz	ok_02
	jmp	fail

ok_02:	mov	a, #0x04
	jnz	ok_04
	jmp	fail

ok_04:	mov	a, #0x08
	jnz	ok_08
	jmp	fail

ok_08:	mov	a, #0x10
	jnz	ok_10
	jmp	fail

ok_10:	mov	a, #0x20
	jnz	ok_20
	jmp	fail

ok_20:	mov	a, #0x40
	jnz	ok_40
	jmp	fail

ok_40:	mov	a, #0x80
	jnz	pass

fail:	FAIL

pass:	PASS
