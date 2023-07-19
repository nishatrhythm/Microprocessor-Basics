include 'emu8086.inc'
.MODEL SMALL
ORG 100H
.DATA
    ARR DB 7 DUP(?)
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    PRINT "ENTER 7 NUMBER IN ARRAY: "
    
    MOV CX,7
    MOV BX,OFFSET ARR
    MOV AH,1
    
    INPUTS:
    INT 21H
    MOV [BX], AL
    INC BX
    LOOP INPUTS
    
    MOV CX, 7
    DEC CX
    
    OUTERLOOP:
    MOV BX,CX
    MOV SI,0
    
    COMPLOOP:
    MOV AL,ARR[SI]
    MOV DL,ARR[SI+1]
    CMP AL,DL
    
    JNC NOSWAP
    
    MOV ARR[SI],DL
    MOV ARR[SI+1],AL
    
    NOSWAP:
    INC SI
    DEC BX
    JNZ COMPLOOP
    
    LOOP OUTERLOOP
    
    ;NEW LINE
    
    MOV AH,2
    MOV DL,10
    INT 21H
    
    MOV DL,13
    INT 21H
    
    PRINT "AFTER SORTING ARRAY IN DESCENDING ORDER: " 
    
    MOV CX,7
    MOV BX,OFFSET ARR
    
    ;THIS LOOP TO DISPLAY ELEMENTS
    OUTPUTS:
    MOV DL,[BX]
    MOV AH,2
    INT 21H
    
    MOV DL,32
    MOV AH,2
    INT 21H 
    
    INC BX
    LOOP OUTPUTS
    
    MAIN ENDP
RET