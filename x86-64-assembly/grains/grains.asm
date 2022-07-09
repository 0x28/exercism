section .text
global square
square:
    lea rcx, [rdi-1]
    cmp rcx, 63
    ja fail

    mov rax, 1
    shl rax, cl
    ret

fail:
    xor rax, rax
    ret

global total
total:
    mov rax, -1
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
