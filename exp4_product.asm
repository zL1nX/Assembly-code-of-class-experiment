; multi-segment executable file template.

data segment
    ; add your data here!
    input1 db "input your N (not bigger than 8): ", 13, 10, '$'
    output db 13, 10,"The product of N is: ",13,10,'$'
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    
    lea dx, input1
    mov ah, 09h
    int 21h
    
    mov ah, 01h
    int 21h 
    
    xor bx, bx
    sub al, 30H 
    
    cmp al, 1
    ja bigger 
    jmp less

bigger:
    mov bl, al
    mov ax, 1    
    jmp product
    
less:
    mov ax, 1
    jmp result
        
    
product:
    mul bx
    sub bx, 1
    cmp bx, 1
    jz result
    loop product

result:
    mov bx, ax 
    lea dx, output
    mov ah, 09h
    int 21h
    mov dx, bx
    call print
    mov ax, 4c00h ; exit to operating system.
    int 21h
    
print proc near
    push dx
    push ax
    push cx
    push bx
    mov cx, 0
convert:
    mov ax, dx 
    mov bx, 10
    mov dx, 0
    div bx
    xchg ax, dx
    add ax, 30H
    push ax
    inc cx
    cmp dx, 0
    jnz convert
show:
    pop ax
    mov dl, al
    call stdout
    loop show
    pop bx
    pop cx
    pop ax
    pop dx
    ret
print endp

stdout proc near
    mov ah, 02h
    int 21h
    ret
stdout endp

        
ends

end start ; set entry point and stop the assembler.
