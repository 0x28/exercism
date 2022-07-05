default rel

section .rodata
translation: db 0,'U',0,'G','A',0,0,'C'

section .text
global to_rna
to_rna:
    lea rbx, [translation]

loop:
    mov al, byte[rdi]

    test al, al
    jz end

    and rax, 0x0f
    mov cl, byte[rbx+rax]
    mov byte[rsi], cl

    inc rdi
    inc rsi
    jmp loop

end:
    mov byte[rsi], 0
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
