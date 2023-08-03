name "lower"  ; Program name

org 100h  ; Origin of the program, 8086 starts at 100h

jmp start  ; Jump to the start of the main program

; Data section:

; String buffer with a maximum size of 20 characters,
; the second byte will hold the actual number of used bytes for the string,
; and all other bytes are for storing characters.
string db 20, 22 dup('?')

new_line db 0Dh, 0Ah, '$'  ; New line code for printing

start:

; Input section:

lea dx, string  ; Load the address of the string buffer into DX

mov ah, 0ah  ; AH = 0Ah for buffered input
int 21h  ; Invoke the DOS interrupt to read a string from the keyboard

mov bx, dx  ; Copy the address of the input buffer into BX
mov ah, 0  ; Clear AH (used for comparison later)
mov al, ds:[bx+1]  ; Load the number of characters read into AL
add bx, ax  ; Move BX to point to the end of the input string

mov byte ptr [bx+2], '$'  ; Add a dollar sign at the end to terminate the string

; Output section:

lea dx, new_line  ; Load the address of the new line code into DX
mov ah, 09h  ; AH = 09h for buffered output
int 21h  ; Invoke the DOS interrupt to print the new line

; Processing section:

lea bx, string  ; Load the address of the string buffer into BX

mov ch, 0  ; Clear CH (used for counting later)
mov cl, [bx+1]  ; Load the number of characters in the string into CL

jcxz null  ; If the string is empty (null), jump to 'null' label

add bx, 2  ; Move BX to point to the start of the actual characters in the string

lower_case:

; Check if it's an upper case letter ('A' to 'Z'):
cmp byte ptr [bx], 'A'
jb ok_lower
cmp byte ptr [bx], 'Z'
ja ok_lower

; Convert to lowercase:

; Upper case letter has the fifth bit set, for example:
; 'A'             : 01000001b
; 'a'             : 01100001b
; Lower case mask : 10111111b

; Set the fifth bit to convert to lowercase:
or byte ptr [bx], 00100000b

ok_lower:
inc bx  ; Move to the next character in the string
loop lower_case  ; Loop until all characters have been processed

; Output the modified string:

lea dx, string+2  ; Load the address of the modified string (skip the control characters)
mov ah, 09h  ; AH = 09h for buffered output
int 21h  ; Invoke the DOS interrupt to print the modified string

; Wait for any key press:

mov ah, 0  ; Clear AH (function for BIOS keyboard input)
int 16h  ; BIOS interrupt to wait for a key press

null:
ret  ; Return to the operating system
