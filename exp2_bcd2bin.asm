; multi-segment executable file template.

data segment
    ; add your data here!
    ;pkey db "press any key...$"
ends

SSTACK	SEGMENT STACK
		DW 64 DUP(?)
SSTACK	ENDS

stack segment
    dw   128  dup(0)
ends

code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax

    ; add your code here
    
    mov [3500H], 09
    mov [3501H], 09
    mov [3502H], 08
    mov [3503H], 01
    mov [3504H], 01
    mov [3505H], 06
    mov [3506H], 00
    mov [3507H], 07
    
    
    
    XOR AX, AX ; ax清零
	MOV CX, 0004H    ; 设置计数器
	MOV SI, 3500H    ; 设置段寄存器起始地址
	MOV DI, 3510H    ; 设置另一个段寄存器起始地址
    A1:	MOV AL, [SI]   ;  将bcd码移入al
	ADD AL, AL     ;  乘2
	MOV BL, AL     ;  保留一个原数乘2
	ADD AL, AL     ;  乘2
	ADD AL, AL     ;  乘2
	ADD AL, BL     ;  原数乘8+原数乘2==原数乘10==十位数
	INC SI         ;  取个位数
	ADD AL, [SI]   ;  直接相加
	MOV [DI], AL   ;  结果移入
	INC SI         ;  进行下一轮操作
	INC DI         ;
	LOOP A1        ;
	MOV AX,4C00H   ;
	INT 21H				;程序终止
  
ends

end start ; set entry point and stop the assembler.
