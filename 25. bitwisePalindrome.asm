DATA SEGMENT 
        X DW 0FFFFH 
        MSG1 DB 10,13,'NUMBER IS PALINDROME$' 
        MSG2 DB 10,13,'NUMBER IS NOT PALINDROME$' 
DATA ENDS 
CODE SEGMENT 
   ASSUME CS:CODE,DS:DATA 
   START: MOV AX,DATA   
          MOV DS,AX   
          MOV AX,X 
          MOV CL,10H   
   UP: ROR AX,1 
          RCL DX,1 
          LOOP UP 
          CMP AX,DX   
          JNZ DOWN 
          LEA DX,MSG1 
          MOV AH,09H 
          INT 21H 
          JMP EXIT 
DOWN: LEA DX,MSG2 
          MOV AH,09H 
          INT 21H 
EXIT:MOV AH,4CH 
          INT 21H 
CODE ENDS 
END START

