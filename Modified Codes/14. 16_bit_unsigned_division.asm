DATA SEGMENT
  NUM1 DW 0014H    ; Dividend (16-bit unsigned number)
  NUM2 DW 0003H    ; Divisor (16-bit unsigned number)
  QUO DW ?         ; Quotient (result of division)
  REM DW ?         ; Remainder (result of division)
DATA ENDS

CODE SEGMENT
  ASSUME CS:CODE, DS:DATA

START:
  MOV AX, DATA     ; Load the data segment into AX
  MOV DS, AX       ; Move the data segment to DS

  ; Perform 16-bit unsigned division:
  MOV AX, NUM1     ; Move the lower word of the Dividend to AX
  XOR DX, DX       ; Clear DX to ensure it's zero for unsigned division
  DIV NUM2         ; Perform unsigned division with NUM2

  ; Store the quotient and remainder:
  MOV QUO, AX      ; Store the quotient in the QUO variable
  MOV REM, DX      ; Store the remainder in the REM variable

  ; Display the result (Quotient and Remainder can be printed with print_num procedure):
  MOV AH, 4CH      ; Function to exit the program
  INT 21H

CODE ENDS
END START
