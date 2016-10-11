; Description: mWriteInt Macro
; Authored by Zhaoyang, 2016-10-11

INCLUDE Irvine32.inc


.data

	_pbyte SBYTE 127
	_pword SWORD 32677
	_pdword SDWORD 2147483647

	_nbyte SBYTE -128
	_nword SWORD -32678
	_ndword SDWORD -2147483648

.code

; ==========================================

mWriteInt MACRO value
	IF type value eq 4
		mov eax, value
	ELSE
		movsx eax, value
	ENDIF
	call WriteInt
ENDM

; ==========================================

main PROC

	mWriteInt _pbyte
	call CrLf
	mWriteInt _pword
	call CrLf
	mWriteInt _pdword
	call CrLf
	mWriteInt _nbyte
	call CrLf
	mWriteInt _nword
	call CrLf
	mWriteInt _ndword
	call CrLf

	exit

main ENDP

END main
