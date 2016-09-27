; Description: 使用 MASM 汇编器实现一个小例程，在屏幕上打印显示个人信息（姓名、 性别、 学号、班级以及其他信息，格式自定义）
; Authored by Zhaoyang, 2016-9-25

INCLUDE Irvine32.inc

.data
string BYTE "Zhaoyang Li, Male, Student ID 2014013432, Class SE41. Hello, world!", 0dh, 0ah, 0

.code
main PROC
    call Clrscr

    mov  edx, OFFSET string
    call WriteString

    exit
main ENDP

END main
