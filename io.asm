; multi-segment executable file template.

data segment
    ; add your data here!
    ; pkey db "press any key...$"
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax

    ; add your code here
    ;����ָ��
    ;mov ax, 1000H
    ;mov bl, al
    ;mov cx, 5678H
    ;mov ss, ax
    
    ;����ָ��
    ;mov ax, 1000H
    ;add al, 30H
    ;add ax, 2000H
    
    ;inc al
    
    ;mov bx, 0040H
    ;sub ax, bx
    
    ;mov al, 0020H
    ;mov ah, 0021H
    ;cmp ah, al
    ;inc al
    ;cmp ah, al
    
    ;mov ax, 0010H
    ;mov bx, 0010H
    ;mul bx 
    
    ;�߼�����ָ��
    ;mov al, 0010H
    ;not al
    
    ;mov ah, 11H
    ;and al, ah
    ;and ah, ah
    
    ;mov ax, 1234H
    ;test ax, 0034H
    ;jnz s
    ;s: mov bx, 0001H
    
    ;or al, 03H
    ;xor al, al
    
    ;��־������CPU����ָ��
    ;STC ;��λ��־λ
    ;CLC ;���λ��־λ
    ;CMC ;��λ��־λȡ��
    ;STD ;�÷����־λ
       
    ;HLT ;ֹͣ����ִ��ָ��  
    ;NOP ;�ղ�������ʱ
    
    ;��λ��ѭ����λָ��
    ;mov ax, 0001H
    ;SAL ax, 1
    ;SHL ax, 1
    ;SAR ax, 2
    
    ;mov ax, 0101H
    ;rol ax, 1
    ;ror ax, 1   
    
    ;�������ָ��
    ;jmp s1
    ;s1: mov ax, 1000H
       
    ;mov bl, 34H
    ;mov al, 24H
    ;s3: test bl,al
    ;jz s4
    ;inc al
    ;jmp s3
    ;s4: mov bl, 0 
    
    ;call proad
    ;proad proc near
        ;mov ax, 1234H
    ;proad endp
    
    ;mov cx, 0010H 
    ;mov ax, 0001H
    
    ;x:inc ax
    ;loop x
   
    
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
