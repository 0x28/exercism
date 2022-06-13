section .text
global rotate
rotate:
    mov r10, rdx
    xor rcx, rcx
    mov r11, 26
    mov r12, 'a'
    mov r13, 'A'

loop:
    xor rax, rax
    xor rbx, rbx
    xor rdx, rdx

    mov al, byte [rdi+rcx]
    test al, al
    jz end

    mov r14, rax
    call is_lower
    cmovbe rbx, r12

    mov r14, rax
    call is_upper
    cmovbe rbx, r13

    test rbx, rbx
    jz continue

    sub al, bl
    add rax, rsi
    div r11
    mov rax, rdx
    add al, bl

continue:
    mov byte [r10+rcx], al
    inc rcx
    jmp loop

end:
    mov byte [r10+rcx], 0
    ret

is_lower:
    sub r14, 'a'
    cmp r14, 25
    ret

is_upper:
    sub r14, 'A'
    cmp r14, 25
    ret
