section .text
global reverse
reverse:
    mov rbx, rdi                ; rbx = begin pointer, rdi = end pointer

    xor rax, rax
    mov rcx, -1
    repne scasb
    lea rdi, [rdi-2]

loop:
    cmp rbx, rdi
    jge end

    mov cl, byte [rbx]
    mov dl, byte [rdi]
    mov byte [rbx], dl
    mov byte [rdi], cl

    inc rbx
    dec rdi

    jmp loop

end:
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
