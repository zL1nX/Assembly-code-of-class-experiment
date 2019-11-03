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
    xor dx, dx;�����ʾ��Ϣ��������ؼĴ���
    
get:  ;��ʼѭ������������Ϣ
    mov ah, 01h
    int 21h
    cmp al, 13   ;���س�ʱ����ѭ��
    jz result
    
    
    cmp al, 60h  ;Сд��ĸ����96
    ja check_lowercase
    
    cmp al, 40h  ;��д��ĸ����64
    ja check_uppercase
    
    cmp al, 2fh  ;���ִ���47
    ja check_digit
    
    jmp cnt_others ;����

check_digit:
    cmp al, 39h  ;����С�ڵ���57
    ja cnt_others
    inc bh       ;���ּ�����
    jmp get

check_uppercase:
    cmp al, 5Ah  ;��д��ĸС�ڵ���90
    ja cnt_others
    inc bl       ;��ĸ������
    jmp get

check_lowercase:
    cmp al, 7Ah  ;Сд��ĸС�ڵ���122
    ja cnt_others
    inc bl       ;��ĸ������
    jmp get

cnt_others:
    inc dh       ;�����ַ�������
    jmp get
    
result:
    mov [di], bh    ;�����Ԥ�洢
    mov [di+1], bl
    mov [di+2], dh
    
    xor dx, dx
    xor bx, bx      ;��ʼ��ӡ��Ϣ
    
    lea dx, output1
    mov ah, 09h
    int 21h
    xor dx, dx
    
    mov dl, [di]
    call print      ;��ӡ��������hexתΪdec��λ���
    
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
