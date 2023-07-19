DATA SEGMENT 
        X DB 0AAH 
        ONE DB ? 
        ZERO DB ? 
DATA ENDS 
CODE SEGMENT 
   ASSUME CS: CODE,DS:DATA
   START:  MOV AX,DATA 
           MOV DS,AX 
           MOV AH,X 
           MOV BL,8 
           MOV CL,1 
   UP:  ROR AH,CL   
           JNC DOWN   
           INC ONE 
           JMP DOWN1   
   DOWN:   INC ZERO 
   DOWN1:  DEC BL  
           JNZ UP 
           MOV AH,4CH 
           INT 21H 
CODE ENDS 
END START
