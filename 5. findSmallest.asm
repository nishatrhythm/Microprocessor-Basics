;SMALLET

.MODEL SMALL
.STACK
.DATA
    
    ARR DB ?
    SMALLEST DB 100
    
    
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
      
      
      
      CALL SMALLESTP
      
       
      
      MOV AH,4CH
      INT 21H 
      
      MAIN ENDP
   


SMALLESTP PROC 

SMALL:    
    CMP [DI], '$';
    JE RETURN;
    MOV BL, SMALLEST
    CMP [DI], BL
    JL STORE_SMALL
    INC DI
    JMP SMALL
    
STORE_SMALL:
    MOV BL, [DI]
    MOV SMALLEST,BL
    INC DI
    JMP SMALL 
    RETURN:
    RET    
    
    SMALLESTP ENDP

    
END MAIN
RET