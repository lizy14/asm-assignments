; Description: 对整数数组求和
; Authored by Zhaoyang, 2016-9-25

INCLUDE Irvine32.inc

.data
intArray WORD 600h, 500h, 400h, 300h, 200h

sum DWORD 0

.code
main PROC

	call Clrscr
	xor ecx, ecx

loop_begin:
	mov eax, lengthof intArray * type intArray
	cmp ecx, eax
	je loop_end

	movzx eax, intArray[ecx]
	add sum, eax

	add ecx, type intArray
	jmp loop_begin
loop_end:

	mov eax, sum
	call WriteInt ;expect 5120
	exit
main ENDP

END main
