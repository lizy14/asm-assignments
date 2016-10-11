; Description: Student Records
; Authored by Zhaoyang, 2016-10-11

INCLUDE Irvine32.inc


.data
filename BYTE "students.csv", 0

file DWORD ?
buffer BYTE 30 DUP(0)
counter DWORD 0

comma BYTE ",", 0
newline BYTE 13, 10, 0

pmt_another_record BYTE "Do you have another record? (y/n): ", 0
pmt_prefix BYTE "Please key-in the student's ", 0
pmt_suffix BYTE ": ", 0
pmt_success_suffix BYTE " records has been written to `students.csv`.", 13, 10, 0
pmt_success_prefix BYTE 13, 10, "A total of ", 0

str_id BYTE "ID", 0
str_name BYTE "name", 0
str_birthday BYTE "birthday", 0
str_header BYTE "id,name,birthday,", 0

.code


; ==========================================

helper PROC, string: DWORD ; read from console and write into `file`, comma terminated

	mov edx, offset pmt_prefix
	call WriteString
	mov edx, string
	call WriteString
	mov edx, offset pmt_suffix
	call WriteString

	mov edx, offset buffer
    mov ecx, sizeof buffer
    call ReadString

	push eax
	mov eax, file
    pop ecx
    call WriteToFile

	mov eax, file
	mov edx, offset comma
	mov ecx, sizeof comma
	call WriteToFile

	ret

helper ENDP

; ==========================================

main PROC


	mov edx, offset filename
    call CreateOutputFile
	mov file, eax

	mov edx, offset str_header
	mov ecx, sizeof str_header
	call WriteToFile

	get_another_record:

	inc counter

	invoke helper, offset str_id
	invoke helper, offset str_name
	invoke helper, offset str_birthday

	mov eax, file
	mov edx, offset newline
	mov ecx, sizeof newline
	call WriteToFile


	mov edx, offset pmt_another_record
	call WriteString

	mov edx, offset buffer
    mov ecx, sizeof buffer
    call ReadString

	.if buffer == 'y'
		mov ecx, 2
	.else
		mov ecx, 1
	.endif

	loop get_another_record



	mov eax, file
    call CloseFile

	mov edx, offset pmt_success_prefix
	call WriteString
	mov eax, counter
	call WriteInt
	mov edx, offset pmt_success_suffix
	call WriteString

	exit

main ENDP

END main
