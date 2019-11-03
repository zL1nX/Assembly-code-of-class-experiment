; multi-segment executable file template.

data segment
    ; add your data here!
    scores db "7","9","C","D","0","P","R","S","Z","O","$";55D,57D,67D,68D,48D,80D,82D,83D,90D,79D
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov cx, 10;计数器
    mov si, offset scores
    xor di, di
    
goon: mov al, [si]
    cmp al, 90 ;大于等于90？
    jc next3   ;
    inc dh     ; 大于的话不跳转，dh加1
    jmp stor
    
next3: cmp al, 70
    jc next5
    inc dl
    jmp stor

next5: cmp al, 60
    jc next7
    inc bh
    jmp stor

next7: inc bl
stor: inc si
    loop goon
    mov [di], dh
    mov [di+1], dl
    mov [di+2], bh
    mov [di+3], bl
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
