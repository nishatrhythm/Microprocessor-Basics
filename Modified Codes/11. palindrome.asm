Data Segment
  str1 db '712218','$'  ; Input string
  strlen1 dw $-str1    ; Length of the input string (excluding the null terminator)
  strrev db 20 dup(' ') ; Buffer to store the reversed string
  str_palin db 'String is Palindrome.','$'   ; Message for palindrome string
  str_not_palin db 'String is not Palindrome.','$'  ; Message for non-palindrome string
Data Ends

Code Segment
  Assume cs:code, ds:data  ; Set the code and data segment registers

  Begin:
    mov ax, data   ; Load the data segment address to AX
    mov ds, ax     ; Move the data segment address to DS
    mov es, ax     ; Move the data segment address to ES (used for rep cmpsb)

    mov cx, strlen1   ; Load the length of the string to CX
    add cx, -2        ; Adjust CX to point to the last character (exclude the null terminator)

    lea si, str1   ; Load the source index with the start of the input string
    lea di, strrev ; Load the destination index with the start of the buffer (reversed string)

    add si, strlen1  ; Move SI to the end of the input string
    add si, -2       ; Adjust SI to point to the last character (exclude the null terminator)

    L1:
       mov al, [si]   ; Load a character from the input string
       mov [di], al   ; Store the character in the reversed string buffer
       dec si         ; Move SI backward (towards the start of the input string)
       inc di         ; Move DI forward (towards the end of the buffer)
       loop L1        ; Repeat the process until all characters are copied

       mov al, [si]   ; Load the last character (first character of the input string)
       mov [di], al   ; Store it in the buffer
       inc di         ; Move DI forward to point to the null terminator
       mov dl, '$'    ; Null terminator
       mov [di], dl   ; Store the null terminator at the end of the reversed string
       mov cx, strlen1 ; Reset CX to the length of the string

    Palin_Check:
       lea si, str1   ; Load SI with the start of the input string
       lea di, strrev ; Load DI with the start of the reversed string buffer
       repe cmpsb     ; Compare the strings until CX=0 or mismatch (reversed string is same as input string)

       jne Not_Palin  ; If there is a mismatch, jump to the label Not_Palin

    Palin:
       mov ah, 09h   ; Function to display a string
       lea dx, str_palin   ; Load DX with the address of the palindrome message
       int 21h        ; Display the palindrome message
       jmp Exit       ; Jump to the Exit label

    Not_Palin:
       mov ah, 09h   ; Function to display a string
       lea dx, str_not_palin   ; Load DX with the address of the non-palindrome message
       int 21h        ; Display the non-palindrome message

    Exit:
       mov ax, 4c00h   ; Function to terminate the program
       int 21h         ; Terminate the program
Code Ends
End Begin
