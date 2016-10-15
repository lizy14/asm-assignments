; Description: DrawRect
; Authored by Zhaoyang, 2016-10-15

INCLUDE Irvine16.inc
.data
saveMode BYTE ?

.code
DrawRectM MACRO x1, x2, y1, y2, color
    push ax
    mov ax, x1
    push ax
    mov ax, x2
    push ax
    mov ax, y1
    push ax
    mov ax, y2
    push ax
    mov ax, 0
    mov ax, color
    push ax
    call DrawRect
    pop ax
    pop ax
    pop ax
    pop ax
    pop ax
    pop ax
ENDM

DrawRect PROC  ;parameters on stack: WORDs x1 (12), y1 (10), x2 (8), y2 (6), color (4)
    push bp
    mov bp, sp

    mov bl,[bp+4] ; line color

    mov cx,[bp+12];x1 ; X-coord of start of line
    mov ax,[bp+8];x2 ; length of line
    sub ax,[bp+12];x1

    mov dx,[bp+10];y1 ; Y-coord of start of line
    call DrawHorizLine ; draw the line now

    mov dx,[bp+6];y2 ; Y-coord of start of line
    call DrawHorizLine ; draw the line now

    mov dx,[bp+10];y1 ; Y-coord of start of line
    mov ax,[bp+6];y2 ; length of line
    sub ax,[bp+10];y1

    mov cx,[bp+12];x1 ; X-coord of start of line
    call DrawVerticalLine ; draw the line now

    mov cx,[bp+8];x2 ; X-coord of start of line
    call DrawVerticalLine ; draw the line now

    pop bp

    ret
DrawRect ENDP

main PROC
    mov ax,@data
    mov ds,ax
    ; Save the current video mode
    mov ah,0Fh ; get video mode
    int 10h
    mov saveMode,al
    ; Switch to a graphics mode
    mov ah,0 ; set video mode
    mov al,12h ; 640 X 480, 16 colors
    int 10h

    DrawRectM 10,20,200,110,red
    DrawRectM 50,60,300,210,yellow
    DrawRectM 70,80,260,170,cyan
    DrawRectM 30,40,240,150,green


    ; Wait for a keystroke
    mov ah,10h ; wait for key
    int 16h

    ; Restore the starting video mode
    mov ah,0 ; set video mode
    mov al,saveMode ; saved video mode
    int 10h
    exit
main endp



; the following code is copied from the testbook.


;------------------------------------------------------
DrawHorizLine PROC
;
; Draws a horizontal line starting at position X,Y with
; a given length and color.
; Receives: CX = X-coordinate, DX = Y-coordinate,
; AX = length, and BL = color
; Returns: nothing
;------------------------------------------------------
.data
currX WORD ?
.code
pusha
mov currX,cx ; save X-coordinate
mov cx,ax ; loop counter
DHL1:
push cx ; save loop counter
mov al,bl ; color
mov ah,0Ch ; draw pixel
mov bh,0 ; video page
mov cx,currX ; retrieve X-coordinate
int 10h
inc currX ; move 1 pixel to the right
pop cx ; restore loop counter
loop DHL1
popa
ret
DrawHorizLine ENDP
;------------------------------------------------------
DrawVerticalLine PROC
;
; Draws a vertical line starting at position X,Y with
; a given length and color.
; Receives: CX = X-coordinate, DX = Y-coordinate,
; AX = length, BL = color
; Returns: nothing
;------------------------------------------------------
.data
currY WORD ?
.code
pusha
mov currY,dx ; save Y-coordinate
mov currX,cx ; save X-coordinate
mov cx,ax ; loop counter
DVL1:
push cx ; save loop counter
mov al,bl ; color
mov ah,0Ch ; function: draw pixel
mov bh,0 ; set video page
mov cx,currX ; set X-coordinate
mov dx,currY ; set Y-coordinate
int 10h ; draw the pixel
inc currY ; move down 1 pixel
pop cx ; restore loop counter
loop DVL1
popa
ret
DrawVerticalLine ENDP
END main
