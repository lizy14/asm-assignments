; Description: Draw Text Colors
; Authored by Zhaoyang, 2016-10-9

INCLUDE Irvine32.inc



.data
sentence BYTE 'Color output is easy!', 13, 10, 0

.code


main PROC
	call Clrscr

	mov edx, OFFSET sentence

	mov ecx, 9

loop_begin:
	mov eax, ecx
	call SetTextColor

	cmp ecx, 12
	jg done

	call WriteString
	inc ecx
	jmp loop_begin

done:
	exit

main ENDP

END main
