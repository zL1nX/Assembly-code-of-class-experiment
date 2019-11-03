; multi-segment executable file template.

data segment
    ; add your data here!
    ; pkey db "press any key...$"
    input db "Input your string, end with Enter: ",13,10,'$'
    output db 13,10,"The total num of A is: ",13,10,'$'
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
    xor bl,bl
    
    lea dx, input
    mov ah, 09h
    int 21h
    
get:mov ah, 01h
    int 21h
    cmp al, 65 ;判断是否为A
    jz cnt
    cmp al, 13 ;判断是否为回车
    jz show
    loop get
 
cnt:inc bl ;若为A计数器递增
    loop get
    
show:lea dx, output
    mov ah, 09h
    int 21h
   ;al存商，dl存余数，不超过16，只用一次除法
    mov ax, bx 
    mov dx, 0
    mov bx, 10
    div bx
    ;按位输出
    mov bl, dl
    add al, 30h
    mov dl, al
    call stdout
   
    add bl,30h
    mov dl, bl
    call stdout
    mov dx,0

    stdout proc near
        mov ah, 2
        int 21h
        ret
    stdout endp
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
