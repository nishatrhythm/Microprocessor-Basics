DATA SEGMENT 
        BIN DW 01A9H 
        BCD DB 2 DUP(0) 
DATA ENDS 
CODE SEGMENT 
        ASSUME CS:CODE,DS:DATA 
 START: MOV AX,DATA   
               MOV DS,AX 
               MOV AX,BIN 
               MOV CL,64H          
               DIV CL 
               MOV BCD+1,AL   
               MOV AL,AH 
               MOV AH,00H 
               MOV CL,0AH 
               DIV CL 
               MOV CL,04 
               ROR AL,CL 
               ADD AL,AH 
               MOV AH,4CH 
               INT 21H 
CODE ENDS 
END START
