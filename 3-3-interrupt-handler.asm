; Description: custom interrupt handler
; Authored by Zhaoyang, 2016-10-17
INCLUDE Irvine16.inc
.data
greeting BYTE 13,10,13,10,13,10,13,10,13,10,"              Welcome to ASM!", 13,10,0
.code


handler PROC
    mov ax, @data
    mov ds, ax
    call ClrScr

    mov dx, OFFSET greeting
    push ds
    mov ax, SEG greeting
    mov ds, ax
    call WriteString
    pop ds

    ret
handler ENDP

main PROC

    ; install handler
    mov ax, SEG handler
    mov ds, ax
    mov dx, OFFSET handler
    mov ah, 25h
    mov al, 1
    int 21h

    ; interrupt
    int 1

    ; Wait for key
    mov ah, 10h
    int 16h

    exit

main ENDP
end main
