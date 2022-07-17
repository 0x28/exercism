section .text
global steps
steps:
    xor rax, rax

    test edi, edi
    jng error

loop:
    cmp rdi, 1
    je end
    inc rax

    bt rdi, 0
    jc odd

    shr rdi, 1
    jmp loop

odd:
    lea rdi, [rdi * 3 + 1]
    jmp loop

end:
    ret

error:
    mov rax, -1
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
