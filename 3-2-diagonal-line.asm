; Description: diagonal line
; Authored by Zhaoyang, 2016-10-15

INCLUDE Irvine16.inc
.data
saveMode BYTE ?

.code

main PROC
    mov ax,@data
    mov ds,ax
    ; Save the current video mode
    mov ah,0Fh ; get video mode
    int 10h
    mov saveMode,al
    ; Switch to a graphics mode
    mov ah,0 ; set video mode
    mov al,12h ; hard-coded for 640 X 480, 16 colors
    int 10h



    ; let's draw the line


    mov al,red ; color
    mov ah,0Ch ; draw pixel
    mov bh,0 ; video page

    mov cx,0 ; X-coordinate
    mov dx,0 ; Y-coordinate

    next_line:
    ; midpoint line algorithm, hard-coded for 4:3 ratio
    int 10h
    inc cx
    inc dx
    int 10h
    inc cx
    inc dx
    int 10h
    inc cx
    int 10h
    inc cx
    inc dx

    cmp cx, 640
    jl next_line




    ; Wait for a keystroke
    mov ah,10h ; wait for key
    int 16h

    ; Restore the starting video mode
    mov ah,0 ; set video mode
    mov al,saveMode ; saved video mode
    int 10h
    exit
main endp

end main
