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
    MOV CX,04H   ;设置计数器
    MOV AH,0H    
L1:MOV AL,DS:[SI]            	
    INC SI
    SAHF                    	;将保存在AH中的标志送至标志寄存器
    ADC AL,[DI]
    AAA                         ;BCD码转换
    LAHF                    	;状态标志保存至AH
    OR AL,30H              	;拼成ASCII码送至AL
    MOV ES:[DI],AL           	;AL →ES:[DI],且DI+1→DI
    INC DI
    LOOP L1                 	;循环完否?
    AND AH,01H             	;截取AH中的CF位→AH
    OR AH,30H              	;拼成ASCII码→AH
    MOV [DI],AH           	;AH送至结果的第五个字节
    MOV AH,02H
    MOV CX,05H              ;重新设置计数器，考虑进位
L2:MOV DL,[DI]           		;从高字节到低字节显示输出
    INT 21H
    DEC DI
    LOOP L2
    MOV AH,4CH
    INT 21H    
CODE  ENDS
    END GO
    