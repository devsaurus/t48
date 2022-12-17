	;; *******************************************************************
	;; Test UPI41 read and write.
	;; *******************************************************************

	INCLUDE	"cpu.inc"
	INCLUDE	"pass_fail.inc"
	INCLUDE "upi41_opcodes.inc"

	ORG	0

	;; Start of test

	;; test IBF empty
	ujnibf	ibfempty
	jmp	fail

ibfempty:
	;; test OBF empty
	ujobf	fail

	;; signal test start
	anl	P1, #~004H

	;; request echo test
	mov	a, #001H
	uout	dbb, a

	;; read input as data
inp1:	ujnibf	inp1
	jf1	fail

	uin	a, dbb

	;; invert and output
	xrl	a, #0FFH

	uout	dbb, a

out1:	ujobf	out1

	;; read next input as command
inp2:	ujnibf	inp2
	jf1	inp2_2
	jmp	fail

inp2_2:	uin	a, dbb
	xrl	a, #001H
	jz	pass


fail:	FAIL

pass:	PASS
