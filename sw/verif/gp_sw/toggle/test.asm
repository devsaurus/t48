	;; *******************************************************************
	;; $Id: test.asm,v 1.1 2004-05-02 19:15:27 arniml Exp $
	;;
	;; Toggle P1[0]
	;; *******************************************************************

	INCLUDE	"cpu.inc"
	INCLUDE	"pass_fail.inc"

	ORG	0

	mov	a, #0FFH

loop:	outl	p1, a
	xrl	a, #001H

	mov	r1, #000H
wait1:
	mov	r0, #000H
wait2:	djnz	r0, wait2
	djnz	r1, wait1

	jmp	loop
