STACK	SEGMENT STACK
		DW 64 DUP(?)
STACK	ENDS

DATA		SEGMENT
SADD		DB  30H,30H,32H,35H,36H		 	;5�����ֱ��Ӧ0 0 2 5 6��ʮ������:00256
tdata       DB  30H,30H,31H,39H,31H
tdata2      DB  39H,39H,39H,39H,39H
DATA		ENDS

CODE		SEGMENT
		ASSUME CS:CODE, DS:DATA
START:	MOV AX, DATA
		MOV DS, AX ;װ��
		MOV AX, OFFSET tdata2
		MOV SI, AX
		MOV BX, 000AH ;10
		MOV CX, 0004H ;�ٳ�һ��10��������4
		MOV AH, 00H ;��ʼ��
		MOV AL, [SI] ;ȡSI�е�һλASCII�룬��30H��ʼ
		SUB AL, 30H ;��ȥ30H�����й�һ��
A1:		IMUL BX ;���з�������Ϊԭ����г˷����۳�10��AX��
		MOV DX, [SI+01] ;ȡ��һλ����Ӧ��ascii�� 
		AND DX, 00FFH ;
		ADC AX, DX ;����λ�ļӷ�
		SBB AX, 30H ;����λ�ļ���
		INC SI ;����
		LOOP A1
		;�ܹ��ٳ�һ��10
CODE 	ENDS          

END START
