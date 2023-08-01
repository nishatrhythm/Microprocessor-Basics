; Set the origin of the code to 100h
org 100h

; Include the file "EMU8086.INC" for using predefined macros
INCLUDE "EMU8086.INC"
                                
; Print the string "ENTER NUMBER: " to ask the user for input
MOV DX, OFFSET MAIN
MOV AH, 9 
INT 21H

; Call the procedure SCAN_NUM to read the user's input and store it in NUM variable
CALL SCAN_NUM
MOV NUM, CX

; Initialize BX to 1 and AX to 1
MOV BX, 1
MOV AX, 1 

; Jump to LABEL1 to start the loop
JMP LABEL1

LABEL1:
; Multiply AX by BX (AX = AX * BX)
MUL BX

; Increment BX by 1 (BX = BX + 1)
INC BX

; Compare BX with NUM, if BX is greater, jump to EXIT to end the loop
CMP BX, NUM
JA EXIT

; Jump back to LABEL1 for the next iteration
JMP LABEL1

EXIT:
; Load the offset of the message string "THE RESULT IS: " into SI
LEA SI, MSG

; Call the procedure PRINT_STRING to display the message
CALL PRINT_STRING

; Call the procedure PRINT_NUM to display the final result (value in AX)
CALL PRINT_NUM

; Return from the main procedure to terminate the program
RET

NUM DW ?

; Define the string "ENTER NUMBER: $" and terminate it with a null character
MAIN DB "ENTER NUMBER: $"

; Define the message string "THE RESULT IS: " and terminate it with a null character
MSG DB 13,10, "THE RESULT IS: ", 0

; Define the predefined macros for printing and scanning numbers and strings
DEFINE_PRINT_NUM
DEFINE_SCAN_NUM
DEFINE_PRINT_NUM_UNS
DEFINE_PRINT_STRING
ret
