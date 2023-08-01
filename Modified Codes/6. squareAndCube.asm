; DATA SEGMENT - Define the data segment
DATA SEGMENT
  X DW 04H          ; Define a word-sized variable X with initial value 04H (hexadecimal)
  SQUARE DW ?       ; Define a word-sized variable SQUARE to store the square of X
  CUBE DW ?         ; Define a word-sized variable CUBE to store the cube of X
; DATA ENDS - End of the data segment
DATA ENDS

; CODE SEGMENT - Define the code segment
CODE SEGMENT
  ASSUME CS:CODE,DS:DATA     ; Set up the segment registers
  START: MOV AX,DATA         ; Move the address of the data segment into AX
  MOV DS,AX                  ; Move the address of the data segment into DS
  MOV AX,X                   ; Move the value of X into AX
  MOV BX,X                   ; Move the value of X into BX
  MUL BX                     ; Multiply AX by BX (AX = AX * BX)
  MOV SQUARE,AX              ; Move the result (square of X) into the SQUARE variable
  MUL BX                     ; Multiply AX by BX again (AX = AX * BX), calculating the cube of X
  MOV CUBE,AX                ; Move the result (cube of X) into the CUBE variable
  MOV AH,4CH                 ; Set the AH register with the exit code for the "INT 21H" call (terminate program)
  INT 21H                    ; Interrupt 21H - DOS service call to terminate the program
; CODE ENDS - End of the code segment
CODE ENDS

END START                    ; End of the program, specifying the entry point at START
