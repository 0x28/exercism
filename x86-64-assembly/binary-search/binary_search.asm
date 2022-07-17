section .text
global find
find:
    test rdi, rdi
    jz notfound

    xor r10, r10
    lea r11, [rsi - 1]

loop:
    cmp r10, r11
    jg notfound

    lea r8, [r10 + r11]         ; i = (begin + end) / 2
    shr r8, 1

    mov r9d, dword [rdi + 4 * r8]
    cmp edx, r9d
    jg greater
    jl less

    mov rax, r8
    ret

greater:
    lea r10, [r8 + 1]           ; end = i + 1
    jmp loop

less:
    lea r11, [r8 - 1]           ; begin = i - 1
    jmp loop

notfound:
    xor rax, rax
    dec rax
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
