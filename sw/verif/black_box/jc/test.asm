	;; *******************************************************************
	;; Test JC instruction.
	;; *******************************************************************

	INCLUDE	"cpu.inc"
	INCLUDE	"pass_fail.inc"

	ORG	0

	;; Start of test
	jc	fail
	mov	a, #0FFH
	add	a, #001H
	jc	pass

fail:	FAIL

pass:	PASS
