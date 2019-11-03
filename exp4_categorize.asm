; multi-segment executable file template.

data segment
    ; add your data here!
    input1 db 'Input your string: ',13, 10, '$'
    output1 db 13, 10,'Digits: ',13, 10, '$'
    output2 db 13, 10,'Characters: ', 13, 10, '$'
    output3 db 13, 10,'Others: ', 13, 10, '$'
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
    
    xor bx, bx
    xor dx, dx;输出提示信息并清零相关寄存器
    
get:  ;开始循环接受输入信息
    mov ah, 01h
    int 21h
    cmp al, 13   ;当回车时跳出循环
    jz result
    
    
    cmp al, 60h  ;小写字母大于96
    ja check_lowercase
    
    cmp al, 40h  ;大写字母大于64
    ja check_uppercase
    
    cmp al, 2fh  ;数字大于47
    ja check_digit
    
    jmp cnt_others ;其他

check_digit:
    cmp al, 39h  ;数字小于等于57
    ja cnt_others
    inc bh       ;数字计数器
    jmp get

check_uppercase:
    cmp al, 5Ah  ;大写字母小于等于90
    ja cnt_others
    inc bl       ;字母计数器
    jmp get

check_lowercase:
    cmp al, 7Ah  ;小写字母小于等于122
    ja cnt_others
    inc bl       ;字母计数器
    jmp get

cnt_others:
    inc dh       ;其他字符计数器
    jmp get
    
result:
    mov [di], bh    ;将结果预存储
    mov [di+1], bl
    mov [di+2], dh
    
    xor dx, dx
    xor bx, bx      ;开始打印信息
    
    lea dx, output1
    mov ah, 09h
    int 21h
    xor dx, dx
    
    mov dl, [di]
    call print      ;打印函数，将hex转为dec后按位输出
    
    lea dx, output2
    mov ah, 09h
    int 21h
    xor dx, dx
    
    mov dl, [di+1]
    call print
    
    lea dx, output3
    mov ah, 09h
    int 21h
    xor dx, dx
    
    mov dl, [di+2]
    call print
   
    mov ax, 4c00h ; exit to operating system.
    int 21h
    
print proc near
    push dx
    push cx
    push ax
    push bx
    mov cx, 0
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
    pop ax
    pop cx
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
