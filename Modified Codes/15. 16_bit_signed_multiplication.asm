DATA SEGMENT
    NUM1 DW 0FFECH   ; Define the two signed 16-bit integers (Multiplicand and Multiplier)
    NUM2 DW 0FFF6H
    PROD DW 2 DUP(0) ; Define a variable to store the 32-bit signed product

DATA ENDS

CODE SEGMENT
    ASSUME CS:CODE, DS:DATA
START:
    MOV AX, DATA     ; Load the data segment address into AX
    MOV DS, AX       ; Move the data segment address to DS

    LEA SI, NUM1      ; Load the address of NUM into SI
    MOV AX, [SI]     ; Load the first 16-bit integer (Multiplicand) into AX

    MOV BX, NUM2 ; Load the second 16-bit integer (Multiplier) into BX

    IMUL BX          ; Perform signed multiplication of AX (Multiplicand) and BX (Multiplier), result in DX:AX

    ; Store the 32-bit signed product (DX:AX) in the PROD variable
    MOV [PROD], AX   ; Store the lower 16 bits of the product in PROD
    MOV [PROD + 2], DX ; Store the upper 16 bits of the product in PROD+2

    MOV AH, 4CH      ; DOS function to terminate the program
    INT 21H          ; Call DOS interrupt

CODE ENDS
END START
