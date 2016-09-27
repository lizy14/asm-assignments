; Description: 使用循环计算 Fibonacci 数列的前 15 个值
; Authored by Zhaoyang, 2016-9-25

INCLUDE Irvine32.inc


limit = 15

.data

last DWORD 1
second_last DWORD 1

newline BYTE 0dh, 0ah, 0

.code
main PROC
	call Clrscr

	mov eax, last 
	call WriteInt
	mov edx, OFFSET newline
	call WriteString
	
	mov eax, last 
	call WriteInt
	mov edx, OFFSET newline
	call WriteString

	xor ecx, ecx ;loop counter

loop_begin:
	mov eax, limit - 2
	cmp eax, ecx
	je loop_end
	
	mov edx, last
	mov eax, last
	add eax, second_last
	mov second_last, edx
	mov last, eax

	call WriteInt
	mov edx, OFFSET newline
	call WriteString

	inc ecx
	jmp loop_begin
loop_end:

	;expect 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610
	exit
main ENDP

END main
