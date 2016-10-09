; Description: Str_concat Procedure
; Authored by Zhaoyang, 2016-10-9

INCLUDE Irvine32.inc



.data
targetStr BYTE "ABCDE", 10 DUP(0)
sourceStr BYTE "FGH", 0

.code

; ==========================================

Str_concat PROC dst:DWORD, src:DWORD



	mov esi, src
	mov edi, dst

	; navigate to the terminating zero of dst
	keep_going:

	mov al, [edi]
	inc edi
	cmp al, 0
	jne keep_going
	dec edi

	; let's do it
	loop_begin:

	mov al, [esi]
	mov [edi], al

	inc esi
	inc edi

	cmp al, 0 ; until terminating zero of src is met
	jne loop_begin

	; done
	mov al, 0
	mov [edi], al
	ret

Str_concat ENDP

; ==========================================

printStrings PROC

	mov edx, OFFSET targetStr
	call WriteString
	call CrLf
	mov edx, OFFSET sourceStr
	call WriteString
	call CrLf
	ret

printStrings ENDP

; ==========================================

main PROC

	call printStrings
	invoke Str_concat, OFFSET targetStr, OFFSET sourceStr
	call printStrings
	exit

main ENDP

END main
