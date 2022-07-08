section .text
global is_pangram
is_pangram:
    xor rax, rax

loop:
    mov cl, byte [rdi]
    test cl, cl
    jz end

    or cl, 0x20
    sub cl, 'a'

    mov rbx, 1
    shl rbx, cl
    or rax, rbx

    inc rdi

    jmp loop

end:
    mov rcx, 0
    and rax, 0x3FFFFFF
    cmp rax, 0x3FFFFFF          ; one bit for every lower case letter -> 1 x 26
    cmovne rax, rcx

    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
