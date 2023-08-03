DATA SEGMENT
  NUM1 DW 0014H     ; Dividend (16-bit signed number)
  NUM2 DW 0FFFBH    ; Divisor (16-bit signed number)
  QUO DW 2 DUP(0)   ; Quotient (result of division)
  REM DW 1 DUP(0)   ; Remainder (result of division)
DATA ENDS

CODE SEGMENT
  ASSUME CS:CODE, DS:DATA

START:
  MOV AX, DATA      ; Load the data segment into AX
  MOV DS, AX        ; Move the data segment to DS

  ; Perform 16-bit signed division:
  MOV AX, NUM1      ; Move the lower word of the Dividend to AX
  MOV DX, NUM1+2    ; Move the upper word of the Dividend to DX
  CWD               ; Convert AX into a signed value (sign extend)
  IDIV NUM2         ; Perform signed division with NUM2

  ; Store the quotient and remainder:
  MOV QUO, AX       ; Store the quotient in the QUO variable
  MOV REM, DX       ; Store the remainder in the REM variable

  ; Display the result (Quotient and Remainder can be printed with print_num procedure):
  MOV AH, 4CH       ; Function to exit the program
  INT 21H

CODE ENDS
END START
