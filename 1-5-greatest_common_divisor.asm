; Description: Greatest Common Divisor
; Authored by Zhaoyang, 2016-9-25

INCLUDE Irvine32.inc



.data
prefix BYTE 'gcd(', 0
dilimeter BYTE ', ', 0
suffix BYTE ') = ', 0
error BYTE '**operands should be non-zero**', 0

newline BYTE 0dh, 0ah, 0

.code


gcd PROC 
; input: ebx, ecx, both interpreted as signed integer
; output: eax
	push ebx
	push ecx
	
	xor eax, eax

	cmp eax, ebx
	jz input_zero
	jle dont_neg_ebx
	neg ebx
dont_neg_ebx:

	cmp eax, ecx
	je input_zero
	jle dont_neg_ecx
	neg ecx
dont_neg_ecx:

loop_start:
	mov eax, ebx
	xor edx, edx
	div ecx
	mov ebx, ecx
	mov ecx, edx
	
	xor eax, eax
	cmp eax, ecx
	jc loop_start

	mov eax, ebx
	jmp return

input_zero:
	mov eax, 0
	jmp return

return:
	pop ecx
	pop ebx
	ret

gcd ENDP





calculate_and_print_gcd PROC
; input: ebx, ecx, both interpreted as signed integer

	call gcd
	push eax

	mov edx, OFFSET prefix
	call WriteString
	
	mov eax, ebx
	call WriteInt
	mov edx, OFFSET dilimeter
	call WriteString
	mov eax, ecx
	call WriteInt
	mov edx, OFFSET suffix
	call WriteString

	pop eax
	cmp eax, 0
	jnz non_zero
	mov edx, OFFSET error
	call WriteString
	jmp done_with_zero
	non_zero:
	call WriteInt
	
	done_with_zero:
	mov edx, OFFSET newline
	call WriteString
	
	ret
calculate_and_print_gcd ENDP





main PROC
	call Clrscr

	mov ebx, 12
	mov ecx, 18
	call calculate_and_print_gcd ;expect 6
		
	mov ebx, 6
	mov ecx, -36
	call calculate_and_print_gcd ;expect 6

	mov ebx, -36
	mov ecx, -24
	call calculate_and_print_gcd ;expect 12

	mov ebx, 233
	mov ecx, 2333
	call calculate_and_print_gcd ;;expect 1

	mov ebx, 233233
	mov ecx, 233233233
	call calculate_and_print_gcd ;expect 233
	
	mov ebx, 2333
	mov ecx, 0
	call calculate_and_print_gcd ;expect error
	
	mov ebx, 60000000h
	mov ecx, 20000000h
	call calculate_and_print_gcd ;expect 20000000h
	exit
main ENDP

END main
