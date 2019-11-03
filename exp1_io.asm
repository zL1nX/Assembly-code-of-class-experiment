DATAS SEGMENT
    Input	DB 'A test for string output!',13,10,'$'
    input2 db 'input some char: ',13,10,'$'
DATAS ENDS
 
CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS
START:

    IN AL, 34H
    OUT 45H, AX
    
    
    MOV AX,DATAS
    MOV DS,AX      ;数据放入DS
  
    ;LEA DX,Input   ;字符串偏移起始DX,同MOV DX,OFFSET ASC指令
    ;MOV AH,9       ;09功能 打印字符串
    ;INT 21H        ;INT 21H是DOS中断功能调用的中断号,调用功能
    
    ;mov dl, 'a'
    ;mov ah, 02h
    ;int 21h
    
    lea dx, input2
    mov ah, 9
    int 21h
    
    mov ah, 01H
    int 21H
    
    
    
    
    
    
    MOV AH,4CH     ;返回DOS系统
    INT 21H
CODES ENDS
    END START
