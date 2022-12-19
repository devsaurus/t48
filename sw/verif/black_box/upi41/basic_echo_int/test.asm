	;; *******************************************************************
	;; Test UPI41 read and write with IBF interrupt.
	;; *******************************************************************

	INCLUDE	"cpu.inc"
	INCLUDE	"pass_fail.inc"
	INCLUDE "upi41_opcodes.inc"

	ORG	0
	jmp	main

	;; ISR
	ORG	3

	mov	r6, a

	uin	a, dbb
	mov	r7, a

	mov	a, r6

	retr

	;; Start of test
main:

	;; test IBF empty
	ujnibf	ibfempty
	jmp	fail

ibfempty:
	;; test OBF empty
	ujobf	fail

	;; set up ISR
	clr	a
	mov	r7, a
	en	i

	;; signal test start
	anl	P1, #~004H

	;; request echo test
	mov	a, #001H
	uout	dbb, a

waitisr:
	mov	a, r7
	jz	waitisr

	;; disable interrupt again
	dis	i

	;; invert and output
	cpl	a
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
