	;; *******************************************************************
	;; $Id: test.asm,v 1.1.1.1 2004-03-25 22:29:16 arniml Exp $
	;;
	;; Test JZ instruction.
	;; *******************************************************************

	INCLUDE	"cpu.inc"
	INCLUDE	"pass_fail.inc"

	ORG	0

	;; Start of test
	mov	a, #0x00
	jz	ok_0
	jmp	fail

ok_0:	mov	a, #0x01
	jz	fail

	mov	a, #0x02
	jz	fail

	mov	a, #0x04
	jz	fail

	mov	a, #0x08
	jz	fail

	mov	a, #0x10
	jz	fail

	mov	a, #0x20
	jz	fail

	mov	a, #0x40
	jz	fail

	mov	a, #0x80
	jz	fail

pass:	PASS

fail:	FAIL
