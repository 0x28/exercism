default rel

section .rodata
prefix: db "One for "
prefixlen: equ $-prefix
you: db "you"
youlen: equ $-you
suffix: db ", one for me.", 0
suffixlen: equ $-suffix+1

section .text
global two_fer
two_fer:
    mov rdx, rdi
    mov rbx, rsi

    mov rdi, rsi
    lea rsi, [prefix]
    mov rcx, prefixlen
    rep movsb

    test rdx, rdx
    jne input

    lea rsi, [you]
    mov rcx, youlen
    jmp copy

input:
    mov rbx, rdi
    mov rcx, -1                 ; 0xfffff...
    xor rax, rax                ; search for null byte
    mov rdi, rdx
    repne scasb                 ; calc string length
    lea rcx, [rcx+1]
    not rcx
    mov rdi, rbx
    mov rsi, rdx

copy:
    rep movsb

    lea rsi, [suffix]
    mov rcx, suffixlen
    rep movsb
    ret
