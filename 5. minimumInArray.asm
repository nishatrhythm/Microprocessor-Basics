.model small
.stack 100h

.data
    arr DB 5 DUP(?)     ; Array to store 5 elements
    msg DB 10, 13, "Enter 5 elements: $"  ; Message to prompt user for input
    smallest DB ?       ; Variable to store the smallest number
    output_msg DB 13, 10, "Smallest number: $"

.code
    mov ax, @data
    mov ds, ax

    lea dx, msg         ; Load address of the message
    mov ah, 09h         ; Function to print the string
    int 21h             ; Display the message

    mov cx, 5           ; Counter for 5 elements
    mov si, offset arr  ; Initialize pointer to the array

input_loop:
    mov ah, 01h         ; Function to read a character from the keyboard
    int 21h             ; Read character

    sub al, 30h         ; Convert ASCII character to numeric value
    mov [si], al        ; Store the input value in the array
    inc si              ; Move to the next element
    loop input_loop     ; Repeat for 5 elements

    ; Find the smallest number in the array
    mov cx, 5           ; Reset counter for 5 elements
    mov al, [offset arr] ; Load the first element into AL
    mov smallest, al    ; Assume the first element is the smallest

compare_loop:
    inc si              ; Move to the next element
    mov al, [si]        ; Load the current element into AL
    cmp al, smallest    ; Compare with the smallest value found so far
    jge not_smallest    ; If the current element >= smallest, go to not_smallest
    mov smallest, al    ; Otherwise, update smallest with the current element

not_smallest:
    loop compare_loop   ; Repeat for remaining elements

    ; Display the "Smallest number: " message
    lea dx, output_msg
    mov ah, 09h
    int 21h

    ; Display the smallest number
    mov dl, smallest    ; Load the smallest value into DL (for display)
    add dl, 30h         ; Convert the numeric value to ASCII character
    mov ah, 02h         ; Function to display a character
    int 21h             ; Display the smallest number

    ; Exit program
    mov ah, 4Ch
    int 21h
end
