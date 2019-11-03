; multi-segment executable file template.

data segment
    ; add your data here! 
    input1 db 'The first string is: ',13,10,'$'
    input2 db 13,10,'The second string is: ',13,10,'$'
    buf1 db "1347ADF$"
    buf2 db "2468ABCDE$"
    output db 13,10,'The merged string is: ',13,10,'$'
    buf3 db 64 dup(0)
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov cx, 0
    
    lea dx, input1  ;打印提示信息以及当前串内容
    mov ah, 09h
    int 21h
    
    lea dx, buf1
    mov ah, 09h
    int 21h
    
    lea dx, input2
    mov ah, 09h
    int 21h
    
    lea dx, buf2
    mov ah, 09h
    int 21h
    
    lea bx, buf1
    lea si, buf2
    lea di, buf3
    
comp:       ; 首先判断当前字符是否为结束符，若是则进行串的附加
    cmp [bx], 24h
    jz append1
    cmp [si], 24h
    jz append2
    mov ax,[bx] ;不是结束符则进行比较
    mov dx,[si]
    cmp al, dl
    jc less   ;判断大小
    jz equal
    ja greater
less:         ;串合并算法，把当前较小值添加到新串
    mov [di], ax
    inc di
    inc bx
    jmp comp
    
equal:
    mov [di], ax
    inc di
    inc bx
    inc si    
    jmp comp
    
greater:
    mov [di], dx
    inc si
    inc di
    jmp comp

    
append1:    ;将未结束的串全部附加到新串中，注意判断结束符
    cmp [si], 24H  ;若另一个串未结束，则开始添加
    jz print
    mov dx, [si]
    mov [di], dx
    inc di
    inc si
    loop append1

append2:
    cmp [bx], 24H
    jz print
    mov ax, [bx]
    mov [di], ax
    inc di
    inc bx
    loop append2

    
print:    
    lea dx, output  ;打印提示信息与新串的内容
    mov ah, 09h
    int 21h
    
    lea dx, buf3
    mov ah, 09h
    int 21h

    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
