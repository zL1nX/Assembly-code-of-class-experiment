; multi-segment executable file template.

data segment
    ; add your data here!
    pkey db "press any key...$"
ends

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
            
    lea dx, pkey
    mov ah, 9
    int 21h        ; output string at ds:dx
    
    ; wait for any key....    
    mov ah, 1
    int 21h
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler. 

code SEGMENT
ASSUME CS:code
start:MOV AH,01H
INT 21H ;�����һ����
MOV BL,AL
SUB BL,30H
MOV AH,01H
INT 21H ;����ڶ�����
SUB AL,30H
MUL BL ;�������
MOV BL,10 ;����
DIV BL
MOV BL,AH
CMP AL,0
JE LP
ADD AL,30H
MOV DL,AL
MOV AH,02H
INT 21H ;����̣���ʮλ
LP: ADD BL,30H
MOV DL,BL
MOV AH,02H
INT 21H ;�������������λ
MOV AH,4CH
INT 21H
code ENDS
END start
                   
                   
                   
                   lea dx, input2
    mov ah, 9
    int 21h
    
    mov ah, 01H
    int 21H