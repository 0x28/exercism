section .text
global is_isogram
is_isogram:
    mov rax, 1
    xor rbx, rbx

loop:
    mov cl, byte[rdi]
    inc rdi
    test cl, cl
    jz end

    or cl, 0x20                 ; to lower
    sub cl, 'a'
    cmp cl, 25                  ; outside of letter range
    ja continue

    bt rbx, rcx
    jc false

    bts rbx, rcx

continue:
    jmp loop

end:
    ret

false:
    xor rax, rax
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
