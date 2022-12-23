	;; *******************************************************************
	;; Test UPI41A DMA.
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
	mov	a, #005H
	uout	dbb, a

	;; setup DMA
	;; read input as data
step1:	ujnibf	step1
	jf1	fail

	uin	a, dbb
	xrl	a, #~005H
	jnz	fail

	uen_dma

	;; Step 2: Request 4 reads via DMA
	mov	r7, #004H
read4dma:
	mov	r0, #020H
dloop2:	djnz	r0, dloop2

	mov	a, r7
	uout	dbb, a

	orl	p2, #040H

step2:	ujobf	step2
	djnz	r7, read4dma

	;; Step 3: Request 4 writes via DMA
	mov	r7, #004H
write4dma:
	mov	r0, #020H
dloop3:	djnz	r0, dloop3

	orl	p2, #040H

step3:	ujnibf	step3

	uin	a, dbb
	xrl	a, r7
	jnz	fail
	jf1	fail

	djnz	r7, write4dma


	;; read next input as command
done:	ujnibf	done
	jf1	done_goon
	jmp	done
done_goon:

	uin	a, dbb
	xrl	a, #005H
	jz	pass


fail:	FAIL

pass:	PASS
