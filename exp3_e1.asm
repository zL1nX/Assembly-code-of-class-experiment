; multi-segment executable file template.

data segment
    ; add your data here!
    pkey db "press any key...$"
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
; set segment registers:

    ; add your code here
    mov ax, data
    mov ds, ax
    mov si, 1500H
    mov [si], 6
    mov [si+1], 4
    mov [si+2], 7
    mov al, [si]
    mov bl, [si+1]
    mul bl
    mov bx, 0
    mov bl, [si+2]
    sub ax, bx        
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
