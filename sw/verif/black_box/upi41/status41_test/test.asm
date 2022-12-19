	;; *******************************************************************
	;; Test UPI41 status bits.
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

	;; request status41 test
	mov	a, #002H
	uout	dbb, a

	;; wait for IBF=1 and F1=1
step1:	ujnibf	step1
	jf1	step1_goon
	jmp	step1
step1_goon:

	;; wait for IBF=1 and F1=0
step2:	ujnibf	step2
	jf1	step2


	;; wait for IBF=1 and F1=1
step3:	ujnibf	step3
	jf1	step3_goon
	jmp	step3
step3_goon:
	;; read IBF and complement F0
	uin	a, dbb
	xrl	a, #~002H
	jnz	fail
	cpl	f0

	;; wait for IBF=1 and F1=0
step4:	ujnibf	step4
	jf1	step4
	;; read IBF and complement F0
	uin	a, dbb
	xrl	a, #~002H
	jnz	fail
	cpl	f0

	;; wait for IBF=1 and F1=1
step5:	ujnibf	step5
	jf1	step5_goon
	jmp	step5
step5_goon:
	;; read IBF and complement F0
	uin	a, dbb
	xrl	a, #002H
	jnz	fail
	cpl	f0
	;; load OBF
	mov	a, #099H
	uout	dbb, a

	;; wait for IBF=1 and F1=0
step6:	ujnibf	step6
	jf1	step6
	;; read IBF and complement F0
	uin	a, dbb
	xrl	a, #002H
	jnz	fail
	cpl	f0
	;; complement F1
	cpl	f1
	;; load OBF
	mov	a, #066H
	uout	dbb, a

	;; read next input as command
done:	ujnibf	done
	jf1	done_goon
	jmp	done
done_goon:

	uin	a, dbb
	xrl	a, #002H
	jz	pass


fail:	FAIL

pass:	PASS
