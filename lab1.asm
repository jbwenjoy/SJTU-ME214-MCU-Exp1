ORG 0000H
LJMP START
ORG 0060H
;shu zi bo ma pan xian shi
START:
	;Display 1-4
	MOV 30H,#01H
	MOV 31H,#02H
	MOV 32H,#03H
	MOV 33H,#04H
	;LCALL DISPLAY
	;MOV R4,#20H; 32 2ROUND
	
;LOOP0:
	;INC 30H;
	;LCALL DISPLAY
	;LCALL DELAY
	;MOV A,30H
	;CJNE A,#0FH,OVER
	;MOV 30H,#00H
    ;OVER:DJNZ R4, LOOP0
	
MAIN:
	;LOOP:
	LCALL READ_BCD
	LCALL DISPLAY
	;LJMP DELAY
	LJMP MAIN
	;SJMP LOOP
	
READ_BCD:
	CLR P1.7
	MOV DPTR,#0BFFFH
	MOVX A,@DPTR
	CPL A
	MOV R0,A
	ANL A,#0FH
	MOV 30H,A
	MOV A,R0
	SWAP A
	ANL A,#0FH
	MOV 31H,A
	SETB P1.7
	MOV DPTR,#0BFFFH
	MOVX A,@DPTR
	CPL A
	MOV R0,A
	ANL A,#0FH
	MOV 32H,A
	MOV A,R0
	SWAP A
	ANL A,#0FH
	MOV 33H,A
RET
	
DISPLAY:
	MOV A,30H
	ANL A,#0FH
	MOV DPTR,#DSEG1
	MOVC A,@A+DPTR
	MOV DPTR,#7FFBH
	MOVX @DPTR,A
	
	MOV A,31H
	ANL A,#0FH
	MOV DPTR,#DSEG1
	MOVC A,@A+DPTR
	MOV DPTR,#7FFAH
	MOVX @DPTR,A

	MOV A,32H
	ANL A,#0FH
	MOV DPTR,#DSEG1
	MOVC A,@A+DPTR
	MOV DPTR,#7FF9H
	MOVX @DPTR,A

	MOV A,33H
	ANL A,#0FH
	MOV DPTR,#DSEG1
	MOVC A,@A+DPTR
	MOV DPTR,#7FF8H
	MOVX @DPTR,A
RET

DSEG1:
	DB 0C0H,0F9H,0A4H,0B0H  ;0,1,2,3
	DB 99H,92H,82H,0F8H  ;4,5,6,7
	DB 80H,90H,88H,83H  ;8,9,10,11
	DB 0C6H,0A1H,86H,8EH  ;12,13,14,15

;Tcy = 1us
DELAY:
	MOV R7,#10
DELAY1:
	MOV R6,#200
DELAY2:
	MOV R5,#248
	DJNZ R5,$
	DJNZ R6,DELAY2
	DJNZ R7,DELAY1
RET

END