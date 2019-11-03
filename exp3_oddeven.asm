; multi-segment executable file template.

data segment
    ; add your data here!
    ;pkey db "press any key...$"
    input1 db "input a number: ",13,10,'$' 
    result1 db 13,10,"It is even",13,10,'$'
    result2 db 13,10,"It is odd",13,10,'$'
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov cx, 16
    lea di, input1
    mov ah, 09h
    int 21h
get:    
    mov ah, 01h
    int 21h
    cmp AL, 13 ;只有当回车时才会进行判断
    jz check
    mov bl, al
    loop get;
    
check:
    sub bl, 48 ;转换为数
    mov al, bl
    mov bl, 2 ;除数
    div bl
    cmp ah, 1 ;判断余数
    jnz next1
    jz next2
next1: 
    lea dx, result1
    mov ah, 09h
    int 21h
    mov ax, 4c00h ; exit to operating system.
    int 21h  
    
    
next2:
    lea dx, result2
    mov ah, 09h
    int 21h 
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
