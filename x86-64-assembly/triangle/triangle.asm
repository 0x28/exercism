section .text

global is_equilateral
is_equilateral:
    movsd xmm0, qword [rsp+8]
    movsd xmm1, qword [rsp+16]
    movsd xmm2, qword [rsp+24]
    call is_triangle
    test rax, rax
    jz false

    comisd xmm0, xmm1
    jne false
    comisd xmm1, xmm2
    jne false
    jmp true

global is_isosceles
is_isosceles:
    movsd xmm0, qword [rsp+8]
    movsd xmm1, qword [rsp+16]
    movsd xmm2, qword [rsp+24]
    call is_triangle
    test rax, rax
    jz false

    comisd xmm0, xmm1
    je true
    comisd xmm1, xmm2
    je true
    comisd xmm2, xmm0
    je true
    jmp false

global is_scalene
is_scalene:
    movsd xmm0, qword [rsp+8]
    movsd xmm1, qword [rsp+16]
    movsd xmm2, qword [rsp+24]
    call is_triangle
    test rax, rax
    jz false

    comisd xmm0, xmm1
    je false
    comisd xmm1, xmm2
    je false
    comisd xmm2, xmm0
    je false
    jmp true

is_triangle:
    pxor xmm4, xmm4
    comisd xmm0, xmm4
    jbe false
    comisd xmm1, xmm4
    jbe false
    comisd xmm2, xmm4
    jbe false
    movsd xmm4, xmm0
    addsd xmm4, xmm1
    comisd xmm4, xmm2
    jb false
    movsd xmm4, xmm1
    addsd xmm4, xmm2
    comisd xmm4, xmm0
    jb false
    movsd xmm4, xmm0
    addsd xmm4, xmm2
    comisd xmm4, xmm1
    jb false
    jmp true

false:
    xor rax, rax
    ret

true:
    mov rax, 1
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
