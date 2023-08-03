DATA SEGMENT
   NUM1 DW 03E8H       ; Multiplicand (16-bit number)
   NUM2 DW 0002H       ; Multiplier (16-bit number)
   PROD DW 2 DUP(0)    ; 32-bit Product (result of multiplication)
DATA ENDS

CODE SEGMENT
   ASSUME CS:CODE, DS:DATA

START:
   MOV AX, DATA        ; Load the data segment into AX
   MOV DS, AX          ; Move the data segment to DS

   LEA SI, NUM1        ; SI points to the Multiplicand (NUM1)
   MOV AX, [SI]        ; Move the value of Multiplicand into AX register

   MOV BX, NUM2        ; Move the value of Multiplier (NUM2) into BX

   MUL BX              ; Perform the multiplication (AX = AX * BX)
                       ; The result will be a 32-bit product in DX:AX

   MOV PROD, AX        ; Store the lower word of the product in PROD
   MOV PROD+2, DX      ; Store the higher word of the product in PROD+2

   MOV AH, 4CH         ; Function to exit the program
   INT 21H

CODE ENDS
END START
