; Description: ʹ�� MASM �����ʵ��һ��С���̣�����Ļ�ϴ�ӡ��ʾ������Ϣ�������� �Ա� ѧ�š��༶�Լ�������Ϣ����ʽ�Զ��壩
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
