ujnibf	MACRO	target
	db	0D6H
	db	target
	ENDM

ujobf	MACRO	target
	db	086H
	db	target
	ENDM

uin	MACRO	a, dbb
	db	022H
	ENDM

uout	MACRO	dbb, a
	db	002H
	ENDM

umov	MACRO	sts, a
	db	090H
	ENDM
