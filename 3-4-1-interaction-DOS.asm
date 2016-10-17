; Description: human-machine interaction, DOS INT 21h
; Authored by Zhaoyang, 2016-10-17
INCLUDE Irvine16.inc
.data

NUMBER_OF_STUDENT = 10

good BYTE " GOOD", 0
fail BYTE " FAIL", 0
fair BYTE " FAIR", 0
backspace BYTE " ", 8, 0
prompt_suffix BYTE "> ", 0

.code


main PROC
    mov ax, @data
    mov ds, ax

    mov cx, NUMBER_OF_STUDENT

    another_student:
    mov ax, NUMBER_OF_STUDENT + 1
    sub ax, cx
    call WriteDec
    mov dx, OFFSET prompt_suffix
    call WriteString
    mov bx, 0
    another_char:
    mov ah, 1
    int 21h

    cmp al, 13
    je no_more_chars
    cmp al, 10
    je no_more_chars
    cmp al, 27
    jne not_escape
    exit
    not_escape:

    cmp al, 8
    jne not_backspace
    mov dx, OFFSET backspace
    call WriteString
    mov ax, bx
    mov bl, 10
    div bl
    mov bx, 0
    mov bl, al

    jmp another_char
    not_backspace:

    cmp al, '0'
    jl another_char
    cmp al, '9'
    jg another_char

    sub al, '0'
    mov ah, 0
    ; call WriteDec
    push ax
    mov al, 10
    mul bl
    mov bx, ax
    pop ax
    add bx, ax
    mov ah, 0
    jmp another_char

    no_more_chars:
    ; call CrLf
    mov ax, bx
    call WriteDec

    cmp bx, 90
    jge print_good
    cmp bx, 60
    jge print_fair
    mov dx, OFFSET fail
    jmp print_finish
    print_fair:
    mov dx, OFFSET fair
    jmp print_finish
    print_good:
    mov dx, OFFSET good
    print_finish:
    call WriteString
    call CrLf

    loop another_student

    exit

main ENDP
end main
