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
    
    lea dx, input1  ;��ӡ��ʾ��Ϣ�Լ���ǰ������
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
    
comp:       ; �����жϵ�ǰ�ַ��Ƿ�Ϊ����������������д��ĸ���
    cmp [bx], 24h
    jz append1
    cmp [si], 24h
    jz append2
    mov ax,[bx] ;���ǽ���������бȽ�
    mov dx,[si]
    cmp al, dl
    jc less   ;�жϴ�С
    jz equal
    ja greater
less:         ;���ϲ��㷨���ѵ�ǰ��Сֵ��ӵ��´�
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

    
append1:    ;��δ�����Ĵ�ȫ�����ӵ��´��У�ע���жϽ�����
    cmp [si], 24H  ;����һ����δ��������ʼ���
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
    lea dx, output  ;��ӡ��ʾ��Ϣ���´�������
    mov ah, 09h
    int 21h
    
    lea dx, buf3
    mov ah, 09h
    int 21h

    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
