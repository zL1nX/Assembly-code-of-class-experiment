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
    
    
    
    XOR AX, AX ; ax����
	MOV CX, 0004H    ; ���ü�����
	MOV SI, 3500H    ; ���öμĴ�����ʼ��ַ
	MOV DI, 3510H    ; ������һ���μĴ�����ʼ��ַ
    A1:	MOV AL, [SI]   ;  ��bcd������al
	ADD AL, AL     ;  ��2
	MOV BL, AL     ;  ����һ��ԭ����2
	ADD AL, AL     ;  ��2
	ADD AL, AL     ;  ��2
	ADD AL, BL     ;  ԭ����8+ԭ����2==ԭ����10==ʮλ��
	INC SI         ;  ȡ��λ��
	ADD AL, [SI]   ;  ֱ�����
	MOV [DI], AL   ;  �������
	INC SI         ;  ������һ�ֲ���
	INC DI         ;
	LOOP A1        ;
	MOV AX,4C00H   ;
	INT 21H				;������ֹ
  
ends

end start ; set entry point and stop the assembler.
