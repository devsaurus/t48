	;; *******************************************************************
	;; $Id: test.asm,v 1.1 2004-04-04 14:21:35 arniml Exp $
	;;
	;; Test XCHD A, @ Rr.
	;; *******************************************************************

	INCLUDE	"cpu.inc"
	INCLUDE	"pass_fail.inc"

testR0R1	MACRO	pos
	inc	r0
	inc	r1
	mov	a, @r0
	cpl	a
	add	a, #~((1 << pos) & 00FH) & ~((1 << ((pos+7) # 8) & 0F0H)) & 0FFH
	cpl	a
	jnz	fail
	mov	a, @r1
	cpl	a
	add	a, #~((1 << pos) & 00FH) & ~((1 << ((pos+7) # 8) & 0F0H)) & 0FFH
	cpl	a
	jnz	fail
	ENDM

	ORG	0

	;; Start of test
	mov	r0, #010H
	mov	r1, #020H
	mov	a, #0FEH
	mov	@r0, a
	mov	@r1, a
	inc	r0
	inc	r1
	mov	a, #0FDH
	mov	@r0, a
	mov	@r1, a
	inc	r0
	inc	r1
	mov	a, #0FBH
	mov	@r0, a
	mov	@r1, a
	inc	r0
	inc	r1
	mov	a, #0F7H
	mov	@r0, a
	mov	@r1, a
	inc	r0
	inc	r1
	mov	a, #0EFH
	mov	@r0, a
	mov	@r1, a
	inc	r0
	inc	r1
	mov	a, #0DFH
	mov	@r0, a
	mov	@r1, a
	inc	r0
	inc	r1
	mov	a, #0BFH
	mov	@r0, a
	mov	@r1, a
	inc	r0
	inc	r1
	mov	a, #07FH
	mov	@r0, a
	mov	@r1, a

	dec	r0
	xchd	a, @r0
	dec	r0
	xchd	a, @r0
	dec	r0
	xchd	a, @r0
	dec	r0
	xchd	a, @r0
	dec	r0
	xchd	a, @r0
	dec	r0
	xchd	a, @r0
	dec	r0
	xchd	a, @r0
	mov	r0, #017H
	xchd	a, @r0

	mov	a, @r1
	dec	r1
	xchd	a, @r1
	dec	r1
	xchd	a, @r1
	dec	r1
	xchd	a, @r1
	dec	r1
	xchd	a, @r1
	dec	r1
	xchd	a, @r1
	dec	r1
	xchd	a, @r1
	dec	r1
	xchd	a, @r1
	mov	r1, #027H
	xchd	a, @r1

	jmp	goon

	ORG	256
	;;
goon:	mov	r0, #00FH
	mov	r1, #01FH
	testR0R1	1
	testR0R1	2
	testR0R1	3
	testR0R1	4
	testR0R1	5
	testR0R1	6
	testR0R1	7
	testR0R1	0

pass:	PASS

fail:	FAIL
