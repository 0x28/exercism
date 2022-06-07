section .text
global distance
distance:
    xor rax, rax

loop:
    mov cl, [rsi]
    mov dl, [rdi]

    test cl, cl
    jz done
    test dl, dl
    jz fail

    inc rsi
    inc rdi
    cmp cl, dl
    je loop
    inc rax
    jmp loop

fail:
    mov rax, -1
    ret

done:
    test dl, dl
    jne fail
    ret
