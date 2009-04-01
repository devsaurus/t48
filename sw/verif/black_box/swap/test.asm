	;; *******************************************************************
	;; $Id$
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
