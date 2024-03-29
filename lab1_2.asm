ORG 0000H
LJMP START
ORG 0060H
;dan du jia fa xian shi
START:
	;Display 1-4
	MOV 30H,#01H
	MOV 31H,#02H
	MOV 32H,#03H
	MOV 33H,#04H
	
MAIN:
	LCALL DISPLAY
LOOP:
	LCALL DELAY
	LCALL ADDONE
	SJMP LOOP
	
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

ADDONE:
	INC 30H
	MOV A,30H
	ANL A,#0FH
	MOV DPTR,#DSEG1
	MOVC A,@A+DPTR
	MOV DPTR,#7FFBH
	MOVX @DPTR,A
	
	INC 31H
	MOV A,31H
	ANL A,#0FH
	MOV DPTR,#DSEG1
	MOVC A,@A+DPTR
	MOV DPTR,#7FFAH
	MOVX @DPTR,A
	
	INC 32H
	MOV A,32H
	ANL A,#0FH
	MOV DPTR,#DSEG1
	MOVC A,@A+DPTR
	MOV DPTR,#7FF9H
	MOVX @DPTR,A
	
	INC 33H
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
;Delay 1ms
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
	
DELAY0001S: 
	MOV R7,#0FFH  ;255
LOOP1:
	NOP
    NOP
    DJNZ R7,LOOP1  ;(1+(1+1+ 2)*255+2)*1us = 1.023ms
RET
END