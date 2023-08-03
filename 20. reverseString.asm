.MODEL SMALL
.STACK 100H
.DATA

; The buffer to store the input string
BUFFER DB 100 DUP ('$')

.CODE
MAIN PROC FAR
    MOV AX, @DATA
    MOV DS, AX

    ; Ask the user to enter a string
    MOV AH, 0AH         ; Function to read a string from standard input (keyboard)
    MOV DX, OFFSET BUFFER
    INT 21H

    ; Call the reverse function with the user input buffer
    LEA SI, BUFFER
    CALL REVERSE

    ; Load the address of the reversed string
    LEA DX, BUFFER+2

    ; Output the reversed string loaded in DX
    MOV AH, 09H
    INT 21H

    ; Interrupt to exit
    MOV AH, 4CH
    INT 21H

MAIN ENDP

REVERSE PROC
    ; Load the offset of the string to be reversed
    MOV SI, OFFSET BUFFER+2

    ; Count the number of characters in the string
    MOV CX, 0H

LOOP1:
    ; Compare if this is the last character (indicated by '$')
    MOV AL, [SI]
    CMP AL, '$'
    JE LABEL1

    ; Else, push it onto the stack
    PUSH AX

    ; Increment the pointer and count
    INC SI
    INC CX

    JMP LOOP1

LABEL1:
    ; Again load the starting address of the string
    MOV SI, OFFSET BUFFER+2

LOOP2:
    ; If count is not equal to zero
    CMP CX, 0
    JE EXIT

    ; Pop the top of the stack into DX
    POP DX

    ; Put the character of the reversed string
    MOV [SI], DL

    ; Increment SI and decrement count
    INC SI
    DEC CX

    JMP LOOP2

EXIT:
    ; Add '$' to the end of the reversed string
    MOV [SI], '$'

    RET
REVERSE ENDP

END MAIN
