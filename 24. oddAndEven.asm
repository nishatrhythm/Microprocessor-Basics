.model small
.stack 100h

.data
    prompt      db  'Enter a number: $'
    even_msg    db  0Dh, 0Ah, 'The number is even.$'
    odd_msg     db  0Dh, 0Ah, 'The number is odd.$'
    newline     db  0Dh, 0Ah, '$'

.code
main proc
    ; Set up data segment
    mov ax, @data
    mov ds, ax

    ; Display prompt to enter a number
    mov ah, 09h         ; DOS function to display a string
    lea dx, prompt      ; Load the offset of the prompt message into DX
    int 21h             ; Call the DOS interrupt to display the message

    ; Read the number from the user
    mov ah, 01h         ; DOS function to read a character from standard input
    int 21h             ; Call the DOS interrupt to read the character
    sub al, '0'         ; Convert ASCII digit to binary (subtract the ASCII value of '0')

    ; Check if the number is even or odd
    test al, 1          ; Test the least significant bit (LSB) to determine if the number is odd or even
    jnz odd_number      ; Jump if the LSB is set (number is odd)

    ; Display the message for even number
    mov ah, 09h         ; DOS function to display a string
    lea dx, even_msg    ; Load the offset of the even message into DX
    int 21h             ; Call the DOS interrupt to display the message
    jmp end_program     ; Jump to the end of the program

odd_number:
    ; Display the message for odd number
    mov ah, 09h         ; DOS function to display a string
    lea dx, odd_msg     ; Load the offset of the odd message into DX
    int 21h             ; Call the DOS interrupt to display the message

end_program:
    ; Display a newline character to improve output formatting
    mov ah, 09h         ; DOS function to display a string
    lea dx, newline     ; Load the offset of the newline character into DX
    int 21h             ; Call the DOS interrupt to display the newline

    ; Exit the program
    mov ah, 4Ch         ; DOS function to exit the program
    int 21h             ; Call the DOS interrupt to terminate the program

main endp

end main
