; multi-segment executable file template.

data segment
    ; add your data here!
    ;pkey db "press any key...$"
    input1 db 'input first number: ',13,10,'$'
    input2 db 13,10,'input another number: ',13,10,'$'
    input3 db 13,10,'the result is: ',13,10,'$'
    
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
    lea dx, input1
    mov ah, 9
    int 21h
    
    mov ah,01h
    INT 21H ;输入第一个数的十位
    sub AL, 30H
    MOV [100H],AL

    MOV AH,01H
    INT 21H ;输入第一个数的个位
    SUB AL,30H
    mov [101H], AL
    
    lea dx, input2
    mov ah, 9
    int 21h
    
    mov ah,01h
    INT 21H ;输入第二个数的十位
    sub AL, 30H
    MOV [102H],AL

    MOV AH,01H
    INT 21H ;输入第二个数的个位
    SUB AL,30H
    mov [103H], AL
    
    mov dl, 64H ;乘数10
    mov al, [101H] ;第一个数的个位数
    mov bl, [103H] ;第二个数的个位数
    imul bl
    mov [104H],al
    xor bl, bl
    xor al, al
    mov al, [100H] ;第二个数的个位数
    mov bl, [102H] ;第二个数的十位数
    imul bl
    imul dl
    mov [105H],ax
    
    mov dl, 0AH ;乘数10
    mov al, [101H] ;第一个数的个位数
    mov bl, [102H] ;第二个数的十位数
    imul bl
    imul dl
    mov [107H],ax
    xor bl, bl
    xor al, al
    mov al, [100H] ;第一个数的十位数
    mov bl, [103H] ;第二个数的个位数
    imul bl
    imul dl
    mov [109H],ax
    
    xor bx, bx
    xor ax, ax
    
    mov al,[104H]
    
    mov bx, [105H]
    add ax, bx
    xor bx, bx
    
    mov bx, [107H]
    add ax, bx
    xor bx, bx 
    
    mov bx, [109H]
    add ax, bx
    mov bx, ax
    
    
    lea dx, input3
    mov ah, 9
    int 21h
    
    mov dx, bx 
    PRINT PROC NEAR 
    PUSH DX
    PUSH AX
    PUSH CX
    PUSH BX
    MOV CX,0
DO:MOV AX,DX
    MOV DX,0
    MOV BX,10
    DIV BX
    XCHG AX,DX
    ADD AL,30H
    PUSH AX
    INC CX
    CMP DX,0
    JNZ DO
DO1:POP AX
    MOV DL,AL
    CALL STDOUT  
    LOOP DO1
    POP BX
    POP CX
    POP AX
    POP DX
    RET
PRINT ENDP
                   
                   
STDOUT PROC NEAR  
     MOV AH,2
     INT 21H
     RET
STDOUT ENDP
   
    
    

    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
