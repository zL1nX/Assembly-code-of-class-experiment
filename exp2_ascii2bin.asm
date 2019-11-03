STACK	SEGMENT STACK
		DW 64 DUP(?)
STACK	ENDS

DATA		SEGMENT
SADD		DB  30H,30H,32H,35H,36H		 	;5个数分别对应0 0 2 5 6，十进制数:00256
tdata       DB  30H,30H,31H,39H,31H
tdata2      DB  39H,39H,39H,39H,39H
DATA		ENDS

CODE		SEGMENT
		ASSUME CS:CODE, DS:DATA
START:	MOV AX, DATA
		MOV DS, AX ;装入
		MOV AX, OFFSET tdata2
		MOV SI, AX
		MOV BX, 000AH ;10
		MOV CX, 0004H ;少乘一次10，所以是4
		MOV AH, 00H ;初始化
		MOV AL, [SI] ;取SI中第一位ASCII码，从30H开始
		SUB AL, 30H ;减去30H，进行归一化
A1:		IMUL BX ;以有符号数作为原则进行乘法，累乘10到AX里
		MOV DX, [SI+01] ;取下一位数对应的ascii码 
		AND DX, 00FFH ;
		ADC AX, DX ;带进位的加法
		SBB AX, 30H ;带借位的减法
		INC SI ;自增
		LOOP A1
		;总共少乘一次10
CODE 	ENDS          

END START
