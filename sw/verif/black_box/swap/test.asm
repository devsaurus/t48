	;; *******************************************************************
	;; $Id: test.asm,v 1.1.1.1 2004-03-25 22:29:17 arniml Exp $
	;;
	;; Test SWAP A.
	;; *******************************************************************

	INCLUDE	"cpu.inc"
	INCLUDE	"pass_fail.inc"

	ORG	0

	;; Start of test
	mov	a, #05AH
	swap	a
	add	a, #05BH
	jnz	fail

	mov	a, #0C8H
	swap	a
	add	a, #074H
	jnz	fail

pass:	PASS

fail:	FAIL
