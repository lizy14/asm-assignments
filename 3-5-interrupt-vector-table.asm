; Description: Interrupt Vector Table
; Authored by Zhaoyang, 2016-10-17

INCLUDE Irvine16.inc
.data
year WORD ?
month BYTE ?
day BYTE ?
dayOfWeek BYTE ?
hours BYTE ?
minutes BYTE ?
seconds BYTE ?
prompt BYTE 13, 10, "Press any key to continue...", 13, 10, 0

.code
main PROC
    mov ax,@data
    mov ds,ax

    call ClrScr
    mov cl, 0

next_line:
    mov ah, 0
    mov al,cl
    mov bx, 1
    call WriteHexB
    mov al, ' '
    call WriteChar
    mov al, cl ;
    mov ah, 35h ; get interrupt vector
    int 21h ; call MS-DOS
    mov ax, BX ; offset
    mov bx, 2
    call WriteHexB
    mov al, ':'
    call WriteChar
    mov ax, ES ; seg
    call WriteHexB
    mov al, ' '
    call WriteChar
    call WriteChar

    ;call CrLf
    inc cl

    mov ch, cl
    and ch, 3
    cmp ch, 0
    jne no_newline
    call CrLf
    no_newline:

    mov ch, cl
    and ch, 63
    cmp ch, 0
    jne no_wait_for_key
    mov dx, OFFSET prompt
    call WriteString
    ; Wait for key
    mov ah, 10h
    int 16h
    call ClrScr
    no_wait_for_key:


    cmp cl, 0 ;number of interrupts to display
    jne next_line

    call CrLf
    mov ah,2Ah
    int 21h
    mov year,cx ;year
    mov month,dh ;month
    mov day,dl ;day
    mov dayOfWeek,al ;day of week


    mov ah,2Ch
    int 21h
    mov hours,ch ;hours
    mov minutes,cl ;minutes
    mov seconds,dh ;seconds


    mov ax, year
    call WriteDec
    mov al, '-'
    call WriteChar
    mov ah, 0
    mov al, month
    call WriteDec
    mov al, '-'
    call WriteChar
    mov al, day
    call WriteDec
    call CrLf

    mov al, hours
    call WriteDec
    mov al, ':'
    call WriteChar
    mov al, minutes
    call WriteDec
    mov al, ':'
    call WriteChar
    mov al, seconds
    call WriteDec
    call CrLf
    exit
main ENDP

end main
