; Description: ¿½±´×Ö·û´®
; Authored by Zhaoyang, 2016-9-25

INCLUDE Irvine32.inc

.data
source BYTE 'Please copy this source string', 0
source_size = $-source

destination BYTE source_size DUP(?)

.code
main PROC
	call Clrscr

	mov  edx, OFFSET source
	call WriteString

	xor ecx, ecx

loop_begin:
	mov al, source[ecx]
	test al, al
	jz loop_end
	mov al, source[ecx]
	mov destination[ecx], al

	inc ecx
	jmp loop_begin
loop_end:

	mov destination[ecx], 0

	mov  edx, OFFSET destination
	call WriteString
	exit
main ENDP

END main
