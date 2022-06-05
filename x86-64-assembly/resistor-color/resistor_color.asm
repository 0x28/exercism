default rel

section .data
black:   db "black",0
brown:   db "brown",0
red:     db "red",0
orange:  db "orange",0
yellow:  db "yellow",0
green:   db "green",0
blue:    db "blue",0
violet:  db "violet",0
grey:    db "grey",0
white:   db "white",0
color_array: dq black,brown,red,orange,yellow,green,blue,violet,grey,white,0

section .text
global color_code
color_code:
    mov rcx, -1

colorloop:
    inc rcx
    lea rsi, [color_array]
    mov rsi, [rsi + rcx * 8]
    test rsi, rsi
    je notfound

    push rdi
    push rcx
    call cmpstring
    pop rcx
    pop rdi
    test rax, rax
    je colorloop

    mov rax, rcx
    ret

notfound:
    mov rax, -1
    ret

global colors
colors:
    lea rax, [color_array]
    ret

cmpstring:
    mov al, [rdi]
    mov bl, [rsi]

    test al, al
    sete cl
    test bl, bl
    sete dl
    and cl, dl
    jne cmptrue

    cmp al, bl
    jne cmpfalse

    inc rdi
    inc rsi
    jmp cmpstring

cmptrue:
    mov rax, 1
    ret

cmpfalse:
    xor rax, rax
    ret
