; Description: Show Procedure Parameters
; Authored by Zhaoyang, 2016-9-25

INCLUDE Irvine32.inc



.data
header BYTE 'Stack parameters:', 13, 10, '---------------------------', 13, 10, 0
prefix BYTE 'Address ', 0
dilimeter BYTE ' = ', 0
.code

; ==========================================

ShowParams PROC ; ecx: paramCount

	mov edx, OFFSET header
	call WriteString

	mov eax, ebp
	add eax, 4 ; magic!

	loop_begin:

	mov edx, OFFSET prefix
	call WriteString

	add eax, 4 ; sizeof DWORD
	call WriteHex

	mov edx, OFFSET dilimeter
	call WriteString

	mov ebx, [eax]
	mov edx, eax
	mov eax, ebx
	call WriteHex
	mov eax, edx

	call CrLf

	loop loop_begin


	call CrLf
	ret

ShowParams ENDP

; ==========================================

MySample PROC first:DWORD, second:DWORD, third:DWORD

	paramCount = 3
	mov ecx, paramCount
	call ShowParams
	ret

MySample ENDP

; ==========================================

MyAnotherSample PROC first:DWORD, second:DWORD

	paramCount = 2
	mov ecx, paramCount
	call ShowParams
	ret

MyAnotherSample ENDP

; ==========================================

main PROC

	invoke MySample, 1234h, 5000h, 6543h
	invoke MyAnotherSample, 16777216h, 23333333h
	exit

main ENDP

END main
