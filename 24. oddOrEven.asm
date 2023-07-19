.DATA
 MSG1 DB 10,13,'Enter a number: $'
 MSG2 DB 10,13,'Result: Provided number is Even$'
 MSG3 DB 10,13,'Result: Provided number is Odd$'
DATA ENDS 

DISPLAY MACRO MSG
 MOV AH,9
 LEA DX,MSG
 INT 21H
 
ENDM

.CODE

MAIN PROC
 
 START:
 
  MOV AX,@DATA
  MOV DS,AX
  
  DISPLAY MSG1
  
  MOV AH,01
  INT 21H
  
  
  
 CHECK:
  
  MOV DL,2
  DIV DL
  CMP AH,0
  JNE ODD
  
 EVEN:
 
  DISPLAY MSG2
  JMP EXIT
  
 ODD:
 
  DISPLAY MSG3
  
 EXIT:
 
  MOV AH,4CH
  INT 21H 
  
CODE ENDS
END START