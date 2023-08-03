.MODEL SMALL
.STACK 100H
.DATA
    PROMPT1 DB 10,10,13,"Enter the number of elements (n): $" ; Prompt message for input
    PROMPT2 DB 10,13,"Enter n'th number: $"                  ; Prompt message for input
    PROMPT3 DB 10,13,"The largest number is: $"             ; Prompt message for output
    SERIES DB 10 DUP(?)              ; Maximum 10 numbers in the series
    SIZE DB ?                        ; Variable to store the number of elements
    LARGEST DB ?                     ; Variable to store the largest number
.CODE
MAIN PROC
    MOV AX, @DATA                   ; Initialize data segment
    MOV DS, AX
    
    MOV AH, 9                       ; Display prompt message for input
    MOV DX, OFFSET PROMPT1
    INT 21H
    
    MOV AH, 01H                     ; Read the number of elements
    INT 21H
    SUB AL, 30H                     ; Convert ASCII digit to decimal
    MOV SIZE, AL                    ; Store the number of elements in SIZE variable
    
    MOV CL, SIZE                    ; Loop counter
    
    LEA BX, SERIES                  ; Load effective address of SERIES array
    
    MOV DL, 1                       ; Initialize counter for prompt message
    
    READ_LOOP:
        MOV AH, 9                   ; Display prompt message for input
        MOV DX, OFFSET PROMPT2
        INT 21H
        
        ADD DL, 30H                 ; Convert counter to ASCII
        
        MOV AH, 01H                 ; Read a number
        INT 21H
        SUB AL, 30H                 ; Convert ASCII digit to decimal
        MOV [BX], AL                ; Store the number in SERIES array
        
        INC BX                      ; Move to the next element
        DEC CL                      ; Decrement loop counter
        
        CMP CL, 0                   ; Check if all numbers are read
        JNE READ_LOOP               ; Repeat until all numbers are read
    
    LEA BX, SERIES                  ; Reset BX to the beginning of the array
    MOV AL, [BX]                    ; Assume the first number is the largest
    MOV LARGEST, AL
    
    INC BX                          ; Move to the next element
    MOV CL, SIZE                    ; Reset loop counter
    
    COMPARE_LOOP:
        MOV AL, [BX]                ; Move the current number to AL
        CMP AL, LARGEST             ; Compare the current number with the largest number
        JBE SKIP_UPDATE             ; Jump if the current number is not larger
        
        MOV LARGEST, AL             ; Update the largest number
        
    SKIP_UPDATE:
        INC BX                      ; Move to the next element
        DEC CL                      ; Decrement loop counter
        
        CMP CL, 0                   ; Check if all numbers are compared
        JNE COMPARE_LOOP            ; Repeat until all numbers are compared
    
    MOV AH, 9                       ; Display prompt message for output
    MOV DX, OFFSET PROMPT3
    INT 21H
    
    MOV DL, LARGEST
    ADD DL, 30H                     ; Convert the largest number to ASCII
    
    MOV AH, 2                       ; Display the largest number
    MOV DL, DL
    INT 21H
    
    EXIT:
    MOV AH, 4CH                     ; Exit program
    INT 21H
MAIN ENDP
END MAIN
