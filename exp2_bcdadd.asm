DATA SEGMENT
  STRING1 DB '5','5','5','5'
  STRING2 DB '5','5','5','5'
DATA  ENDS 

CODE  SEGMENT    
  ASSUME CS:CODE,DS:DATA,ES:DATA
GO:MOV AX,DATA
    MOV DS,AX
    MOV ES,AX
    MOV SI,OFFSET STRING1
    MOV DI,OFFSET STRING2
    MOV CX,04H   ;���ü�����
    MOV AH,0H    
L1:MOV AL,DS:[SI]            	
    INC SI
    SAHF                    	;��������AH�еı�־������־�Ĵ���
    ADC AL,[DI]
    AAA                         ;BCD��ת��
    LAHF                    	;״̬��־������AH
    OR AL,30H              	;ƴ��ASCII������AL
    MOV ES:[DI],AL           	;AL ��ES:[DI],��DI+1��DI
    INC DI
    LOOP L1                 	;ѭ�����?
    AND AH,01H             	;��ȡAH�е�CFλ��AH
    OR AH,30H              	;ƴ��ASCII���AH
    MOV [DI],AH           	;AH��������ĵ�����ֽ�
    MOV AH,02H
    MOV CX,05H              ;�������ü����������ǽ�λ
L2:MOV DL,[DI]           		;�Ӹ��ֽڵ����ֽ���ʾ���
    INT 21H
    DEC DI
    LOOP L2
    MOV AH,4CH
    INT 21H    
CODE  ENDS
    END GO
    