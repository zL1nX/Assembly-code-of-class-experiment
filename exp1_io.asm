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
    MOV DS,AX      ;���ݷ���DS
  
    ;LEA DX,Input   ;�ַ���ƫ����ʼDX,ͬMOV DX,OFFSET ASCָ��
    ;MOV AH,9       ;09���� ��ӡ�ַ���
    ;INT 21H        ;INT 21H��DOS�жϹ��ܵ��õ��жϺ�,���ù���
    
    ;mov dl, 'a'
    ;mov ah, 02h
    ;int 21h
    
    lea dx, input2
    mov ah, 9
    int 21h
    
    mov ah, 01H
    int 21H
    
    
    
    
    
    
    MOV AH,4CH     ;����DOSϵͳ
    INT 21H
CODES ENDS
    END START
