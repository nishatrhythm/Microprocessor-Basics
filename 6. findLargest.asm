;LARGEST

.MODEL SMALL
.STACK
.DATA
    
    ARR DB ?
    LARGEST DB 0
    
    

    
.CODE

MAIN PROC
   
   MOV AX,@DATA
   MOV DS,AX
   MOV SI, OFFSET ARR
   MOV DI,SI
   
   MOV CX,5
   
   INPUT:
      MOV AH,01
      INT 21H
      SUB AL,48
      MOV [SI], AL
      INC SI
      LOOP INPUT:
      
      MOV [SI], '$'
      MOV SI, DI
      
      CALL LARGESTP
      

      

      
      MOV AH,4CH
      INT 21H 
      
      MAIN ENDP
   
LARGESTP PROC
    
BIG:
    CMP [SI], '$'
    JE RETURN;
    MOV BL,LARGEST
    CMP [SI],BL
    JG STORE_BIG
    INC SI
    JMP BIG

STORE_BIG:
    MOV BL,[SI]
    MOV LARGEST,BL
    INC SI
    JMP BIG
    
    RETURN:
    RET    
    
    LARGESTP ENDP   
    
END MAIN
RET