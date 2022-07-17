section .text
global square_of_sum
square_of_sum:
    mov rax, rdi

    inc rdi                     ; (n * (n + 1) / 2) ^ 2
    mul rdi
    shr rax, 1
    imul rax, rax

    ret

global sum_of_squares
sum_of_squares:
    mov rax, rdi
    mov rcx, rdi
    xor rdx, rdx

    inc rcx                     ; n * (n + 1) * (2 * n + 1) / 6
    mul rcx

    shl rdi, 1
    inc rdi
    mul rdi

    mov rcx, 6
    div rcx

    ret

global difference_of_squares
difference_of_squares:
    mov r10, rdi
    call sum_of_squares
    mov rcx, rax

    mov rdi, r10
    call square_of_sum
    sub rax, rcx

    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
