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
    ;传送指令
    ;mov ax, 1000H
    ;mov bl, al
    ;mov cx, 5678H
    ;mov ss, ax
    
    ;算术指令
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
    
    ;逻辑运算指令
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
    
    ;标志处理与CPU控制指令
    ;STC ;进位标志位
    ;CLC ;清进位标志位
    ;CMC ;进位标志位取反
    ;STD ;置方向标志位
       
    ;HLT ;停止，不执行指令  
    ;NOP ;空操作，延时
    
    ;移位和循环移位指令
    ;mov ax, 0001H
    ;SAL ax, 1
    ;SHL ax, 1
    ;SAR ax, 2
    
    ;mov ax, 0101H
    ;rol ax, 1
    ;ror ax, 1   
    
    ;程序控制指令
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
