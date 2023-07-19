DATA SEGMENT 
   NUM1 DW 0FFFFH,0FFFFH 
   NUM2 DW 1111H,1111H 
   SUM  DW 4 DUP(0) 
dATA ENDS 
CODE SEGMENT 
     ASSUME CS:CODE,DS:DATA 
START: MOV AX,DATA 
        MOV DS,AX 
        MOV AX,NUM1            
       ADD AX,NUM2    
       MOV SUM,AX     
       MOV AX,NUM1+2     
       ADC AX,NUM2+2                
;Move LSB of  NUM1 to AX  
;Add  LSB of NUM2   to AX 
;Store the LSB   in SUM  
; Move MSB of  NUM1 to AX 
; Add  MSB of NUM2   to AX 
    JNC DOWN                                   ; Check for carry 
       MOV SUM+4,01H 
DOWN:  MOV SUM+2,AX   
            MOV AH,4CH 
            INT 21H 
CODE ENDS 
END START 
