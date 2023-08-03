.model small

.code
    org 100h

start:
    ; Display a message to prompt the user to enter the first number
    mov ah, 09h
    lea dx, msg1
    int 21h

    ; Read the first number
    mov ah, 01h
    int 21h
    sub al, '0'   ; Convert ASCII to binary
    mov num1, al

    ; Display a message to prompt the user to enter the second number
    mov ah, 09h
    lea dx, msg2
    int 21h

    ; Read the second number
    mov ah, 01h
    int 21h
    sub al, '0'   ; Convert ASCII to binary
    mov num2, al

    ; Calculate sum
    mov al, num1
    add al, num2
    mov sum, al

    ; Display the sum
    mov ah, 09h
    lea dx, summation_msg
    int 21h

    mov ah, 0
    mov al, sum
    add al, '0'   ; Convert binary to ASCII
    mov dl, al
    mov ah, 02h
    int 21h

    ; Find smaller number
    mov al, num1
    cmp al, num2
    jae num2_smaller
    mov smaller, al
    jmp done

num2_smaller:
    mov al, num2
    mov smaller, al

done:
    ; Display the smaller number
    mov ah, 09h
    lea dx, msg3
    int 21h

    mov ah, 0
    mov al, smaller
    add al, '0'   ; Convert binary to ASCII
    mov dl, al
    mov ah, 02h
    int 21h

    ; Exit
    mov ah, 4Ch
    int 21h

.data
    num1 db ?
    num2 db ?
    sum db ?
    smaller db ?

msg1 db "Enter the first number: $"
msg2 db 0Dh, 0Ah, "Enter the second number: $"
msg3 db 0Dh, 0Ah, "Smallest number: $"
summation_msg db 0Dh, 0Ah, "Summation: $"

end start
