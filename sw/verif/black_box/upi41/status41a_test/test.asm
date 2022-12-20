	;; *******************************************************************
	;; Test UPI41A extra status bits.
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

	;; request status41a test
	mov	a, #003H
	uout	dbb, a

	;; wait for IBF=1 and F1=1
step1:	ujnibf	step1
	jf1	step1_goon
	jmp	fail
step1_goon:
	uin	a, dbb
	xrl	a, #003H
	jnz	fail

	mov	a, #0AAH
	umov	sts, a
	jf1	step1_f1_ok
	jmp	fail
step1_f1_ok:

	mov	a, #001H
	uout	dbb, a


	;; wait for IBF=1 and F1=0
step2:	ujnibf	step2
	jf1	fail

	uin	a, dbb
	xrl	a, #~003H
	jnz	fail

	mov	a, #055H
	umov	sts, a
	jf1	fail

	mov	a, #002H
	uout	dbb, a


	;; wait for IBF=1 and F1=1
step3:	ujnibf	step3
	jf1	step3_goon
	jmp	fail
step3_goon:
	uin	a, dbb
	xrl	a, #003H
	jnz	fail

	mov	a, #00AH
	umov	sts, a
	jf1	step3_f1_ok
	jmp	fail
step3_f1_ok:

	mov	a, #003H
	uout	dbb, a

	;; wait for IBF=1 and F1=0
step4:	ujnibf	step4
	jf1	fail

	uin	a, dbb
	xrl	a, #~003H
	jnz	fail

	mov	a, #005H
	umov	sts, a
	jf1	fail

	mov	a, #004H
	uout	dbb, a

	;; read next input as command
done:	ujnibf	done
	jf1	done_goon
	jmp	done
done_goon:

	uin	a, dbb
	xrl	a, #003H
	jz	pass


fail:	FAIL

pass:	PASS
