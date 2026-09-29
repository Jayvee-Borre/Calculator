.model small
.stack
.data
        tst     db  0dh, 0ah, 'this is a test message$', 0dh, 0ah
        wi_msg  db  'Invalid input length or value!$', 0dh, 0ah ; wrong input message
        menu    db      0dh, 0ah, '=========CALCULATOR==========', 0dh, 0ah
                db      '1. Addition', 0dh, 0ah
                db      '2. Subtraction', 0dh, 0ah
                db      '3. Multiplication', 0dh, 0ah
                db      '4. Divison', 0dh, 0ah, '$'
        prompt  db  'Enter input: $'
        buff    db  20,0,20 dup(0)
        temp    db  20 dup(0)
.code
main    proc
        mov ax,@data
        mov ds,ax
        mov es,ax

get_prompt:
        ; Show menu
        mov ah,9
        mov dx,offset menu
        int 21h

        ; Prompt user
        mov ah,9
        mov dx,offset prompt
        int 21h

        ; User input place it into the buffer variable
        mov ah,0ah
        mov dx,offset buff
        int 21h

        ; Point to buff/temp
        mov si,offset buff
        mov di,offset temp

        ; get loop counter
        inc si
        lodsb
        mov ch,0

        ; User entered an extra character
        cmp al,1
        mov cl,al
        jne wrong_input
        jmp valid_input

wrong_input: ; If the user input length > 1
        mov ah,9
        mov dx,offset wi_msg
        int 21h
        jmp get_prompt

valid_input: ; if the user inputs a single character input
        ; copy below if you need a test logic
        mov ah,9
        mov dx,offset tst
        int 21h

        mov ah,4ch
        int 21h

main    endp
end     main