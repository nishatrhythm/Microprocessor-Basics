.model small 
.data
str1 db "Enter the First Number: $"
str2 db 13,10,"Enter the Second Number: $"
str3 db 13,10,"Summation of Two Number is: $"
.code
main proc
    mov ax,@data
    mov ds,ax
    lea dx,str1
    mov ah,9
    int 21h
    mov ah,1
    int 21h
    mov bl,al
    lea dx,str2
    mov ah,9
    int 21h
    mov ah,1
    int 21h
    mov bh,al
    sub bh,48
    sub bl,48
    lea dx,str3
    mov ah,9
    int 21h   
    add bh,bl
    add bh,48
    mov dl,bh
    mov ah,2
    int 21h
    mov ah,4Ch
    int 21h
main endp
end