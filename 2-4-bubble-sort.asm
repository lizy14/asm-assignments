; Description: Bubble sort with swap flag
; Authored by Zhaoyang, 2016-10-9

INCLUDE Irvine32.inc



.data
myAnotherArray WORD 39, 97, 17, 46, 22, 36, 1, 71, 99, 60
myArray WORD 3, 1, 7, 5, 2, 9, 4, 3
dilimeter BYTE ', ', 0

.code

; ==========================================

BubbleSort PROC arr:DWORD, number_of_elements:DWORD ; array of WORD

	mov esi, arr
	mov eax, number_of_elements

	push ebp
	mov ebp, esp
	sub esp, 16

	mov DWORD PTR [ebp-16], eax
	; length -> n
	; array  -> esi

	;int j, f, i, n;
	;...-4.-8.-12.-16

	;swap_flag = 1;
	mov DWORD PTR [ebp-8], 1

	;for (i = 1; (i <= length); i++)
	mov DWORD PTR [ebp-12], 1

	outer_for_step:
	mov eax, DWORD PTR [ebp-12]
	mov ebx, DWORD PTR [ebp-16]
	cmp eax, ebx
	jg outer_for_finished


	;   if (!f) break;
		mov ebx, DWORD PTR [ebp-8]
		cmp ebx, 0
		jz outer_for_finished


	;   f = 0;
		mov DWORD PTR [ebp-8], 0


	;	for (j = 0; j < (length - 1); j++)
		mov DWORD PTR [ebp-4], 0

		inner_for_step:
		mov eax, DWORD PTR [ebp-16]
		dec eax
		cmp DWORD PTR [ebp-4], eax
		jge inner_for_finished

	;		if (array[j + 1] > array[j])
			;........cx............dx....
			mov edi, esi
			add edi, DWORD PTR [ebp-4]
			add edi, DWORD PTR [ebp-4]
			mov dx, [edi]
			add edi, 2 ; size of WORD
			mov cx, [edi]

			cmp cx, dx
			jg inner_if_finished


	;			temp = array[j];
	;			array[j] = array[j + 1];
	;			array[j + 1] = temp;
				mov [edi], dx
				sub edi, 2 ; size of WORD
				mov [edi], cx


	;			f = 1;
				mov DWORD PTR [ebp-8], 1

			inner_if_finished:

		inc DWORD PTR [ebp-4]
		jmp inner_for_step

		inner_for_finished:

	inc WORD PTR [ebp-12]
	jmp outer_for_step

	outer_for_finished:
	mov esp, ebp
	pop ebp
	ret

BubbleSort ENDP

; ==========================================

PrintArray PROC arr:DWORD, number_of_elements:DWORD ; array of WORD

	mov ecx, number_of_elements
	mov esi, arr
	xor eax, eax

	loop_begin:
	mov al, [esi]
	call WriteInt
	mov edx, OFFSET dilimeter
	call WriteString
	add esi, 2 ; length of WORD
	loop loop_begin

	call CrLf
	ret

PrintArray ENDP

; ==========================================

test_on_array MACRO arr
	invoke PrintArray, OFFSET arr, lengthof arr
	invoke BubbleSort, OFFSET arr, lengthof arr
	invoke PrintArray, OFFSET arr, lengthof arr
ENDM

main PROC

	test_on_array myArray
	test_on_array myAnotherArray

	exit

main ENDP

END main
