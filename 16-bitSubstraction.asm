DATA SEGMENT 
   NUM DW  4567H,2345H 
   DIF DW 1  DUP(0) 
DATA ENDS 
CODE SEGMENT 
     ASSUME

START:   MOV AX,DATA 
       MOV DS,AX 
       CLC 
; Clearing Carry 
       LEA SI,NUM                     ; SI pointed to the NUM 
       MOV AX,[SI]                    ; Move NUM1 to AX 
       SBB AX,[SI+2]       
; Move the SI to Num2 and subtract with AX(Takes  
                                                   ;care for both smaller as well  as larger
                                                   ;Number subtraction) 
       MOV DIF,AX                    ;Store the result 
       MOV AH,4CH 
       INT 21H 
CODE ENDS 
END START
