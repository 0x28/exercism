section .text
global leap_year

leap_year:
    xor rdx, rdx
    mov rax, rdi
    mov rbx, 400
    div rbx
    test rdx, rdx
    je true

    xor rdx, rdx
    mov rax, rdi
    mov rbx, 100
    div rbx
    test rdx, rdx
    je false

    xor rdx, rdx
    mov rax, rdi
    mov rbx, 4
    div rbx
    test rdx, rdx
    jne false
true:
    mov rax, 1
    ret
false:
    xor rax, rax
    ret
