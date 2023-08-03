DATA SEGMENT
    NUM DB ?                 ; Define NUM as a single-byte variable to store the user input
    MES1 DB 10,13,'DATA IS POSITIVE $'
    MES2 DB 10,13,'DATA IS NEGATIVE $'
    MESSAGE DB 10,13,'Enter a number: $'
DATA ENDS

CODE SEGMENT
    ASSUME CS:CODE, DS:DATA   ; Set up the segment registers

START:
    MOV AX, DATA             ; Load the address of the data segment into the AX register
    MOV DS, AX               ; Set the data segment register (DS) to point to the data segment

    ; Print "Enter a number:" message
    MOV DX, OFFSET MESSAGE   ; Load the address of the message into DX
    MOV AH, 09H              ; Set the print function AH to display a string
    INT 21H                  ; Display the message

    ; Ask the user to enter a number and store it in the NUM variable
    MOV AH, 01               ; Function to read a character from standard input (keyboard)
    INT 21H                  ; Read a character (ASCII value of the input digit)
    MOV BL, AL               ; Store the first character in BL

    ; Check if the number is negative (if the first character is '-')
    CMP BL, '-'              ; Compare BL with ASCII value of '-'
    JNZ READ_NEXT           ; If not '-', it's a positive number, proceed to read the next character

    ; If the code reaches here, it means the user entered a negative number
    MOV AH, 01               ; Read the next character (ASCII value of the next digit)
    INT 21H                  ; Read the next character (ASCII value of the input digit)
    SUB AL, 30H              ; Convert ASCII digit to its numeric value

    ; Calculate the 8-bit signed value of the negative number
    NEG AL                   ; Negate the value of AL (convert to negative)
    MOV NUM, AL              ; Store the numeric value in the NUM variable
    JMP CHECK_SIGN          ; Jump to CHECK_SIGN to check for positive/negative

READ_NEXT:
    SUB BL, 30H              ; Convert ASCII digit to its numeric value
    MOV NUM, BL              ; Store the numeric value in the NUM variable

CHECK_SIGN:
    MOV AL, NUM              ; Move the value of NUM to AL for further processing
    ROL AL, 1                ; Rotate the contents of AL to the left by 1 bit
    JC NEGA                  ; If the carry flag is set after the rotation, the number is negative

    ; If the code reaches here, it means the number is positive
    MOV DX, OFFSET MES1      ; Load the address of the positive message into DX
    JMP EXIT                 ; Jump to the EXIT label to terminate the program

NEGA:
    ; If the code reaches here, it means the number is negative
    MOV DX, OFFSET MES2      ; Load the address of the negative message into DX

EXIT:
    MOV AH, 09H              ; Set the print function AH to display a string
    INT 21H                  ; Display the appropriate message

    MOV AH, 4CH              ; Set the exit function AH
    INT 21H                  ; Terminate the program

CODE ENDS
END START
