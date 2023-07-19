include 'emu8086.inc'
ORG 100H

.MODEL SMALL
.DATA
    ARR DB 7 DUP(?)
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    PRINT "ENTER 7 NUMBER IN ARRAY:"
    
    MOV CX,7
    MOV BX,OFFSET ARR
    MOV AH,1
    
    INPUT:
    INT 21H
    MOV [BX], AL
    INC BX
    LOOP INPUT
    
    MOV CX, 7
    DEC CX
    
    OUTERLOOP:
    MOV BX,CX
    MOV SI,0
    
    COMPLOOP:
    MOV AL,ARR[SI]
    MOV DL,ARR[SI+1]
    CMP AL,DL
    
    JC NOSWAP
    
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
    
    PRINT "AFTER SORTING ARRAY IN ASSENDING ORDER:" 
    
    MOV CX,7
    MOV BX,OFFSET ARR
    
    ;THIS LOOP TO DISPLAY ELEMENTS
    OUTPUT:
    MOV DL,[BX]
    MOV AH,2
    INT 21H
    
    MOV DL,32
    MOV AH,2
    INT 21H 
    
    INC BX
    LOOP OUTPUT
    
    MAIN ENDP
RET