; multi-segment executable file template.

data segment
    ; add your data here!
    output1 db "The final result is: ",13,10,'$'
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
    
    xor ax, ax
    xor bx, bx
    xor dx, dx ;������ȫ������
    ; add your code here  
    mov al, 1
    mov bl, 2
    mov dl, 1  ;��ʼ���Ĵ���
    
loop_mul:  
    mov al, bl
    add al, 1  ;al�洢�˷����
    mul bl
    add bl, 1  ;bl����N�ı仯
    cmp al, 200
    ja result
    add dx, ax ;dx��Ϊ�ۼ���
    loop loop_mul

result:     
    mov bx, dx 
    lea dx, output1
    mov ah, 09h
    int 21h
    
    
print proc near
    push dx
    push ax
    push cx
    push bx
    mov cx, 0
    mov dx, bx
convert: 
    mov ax, dx
    mov dx, 0
    mov bx, 10
    div bx
    xchg ax, dx
    add al, 30h
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

    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
t to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
