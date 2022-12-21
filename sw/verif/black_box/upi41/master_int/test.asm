	;; *******************************************************************
	;; Test UPI41A master interrupts.
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

	;; request master interrupt test
	mov	a, #004H
	uout	dbb, a

	;; read input as data
step1:	ujnibf	step1
	jf1	fail

	uin	a, dbb
	xrl	a, #~004H
	jnz	fail

	;; set up master interrupt flags
	uen_flags
	orl	p2, #00110000B

	;; read input as command
step2:	ujnibf	step2
	jf1	step2_goon
	jmp	fail
step2_goon:
	uin	a, dbb
	xrl	a, #004H
	jnz	fail

	;; read turnover byte as data
step3:	ujnibf	step3
	jf1	fail

	uin	a, dbb
	xrl	a, #0AAH
	jnz	fail

	;; disable IBF interrupt
	anl	p2, #~00100000B

	;; send step4 indicator
	mov	a, #040H
	uout	dbb, a
step4:	ujobf	step4

	;; set step5 indicator
	mov	a, #050H
	uout	dbb,a
step5:	ujobf	step5

	;; read next input as command
done:	ujnibf	done
	jf1	done_goon
	jmp	done
done_goon:

	uin	a, dbb
	xrl	a, #004H
	jz	pass


fail:	FAIL

pass:	PASS
