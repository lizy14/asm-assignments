; Description: 对整数数组求和
; Authored by Zhaoyang, 2016-9-25

INCLUDE Irvine32.inc

.data
intArray WORD 600h, 500h, 400h, 300h, 200h

.code
main PROC
  call Clrscr
  xor eax, eax
  movzx ecx, intArray
  add eax, ecx
  movzx ecx, intArray + 2
  add eax, ecx
  movzx ecx, intArray + 4
  add eax, ecx
  movzx ecx, intArray + 6
  add eax, ecx
  movzx ecx, intArray + 8
  add eax, ecx
  call WriteInt ;expect 5120
  exit
main ENDP

END main
