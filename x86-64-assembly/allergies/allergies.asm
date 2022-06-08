section .text
global allergic_to
allergic_to:
    mov rcx, rdi
    mov rax, 1
    shl rax, cl
    and rax, rsi
    ret

global list
list:
    and rdi, 0xff
    popcnt rax, rdi
    mov dword [rsi], eax
    mov rcx, 1
    mov rdx, 0

loop:
    test rdi, rdi
    jz end
    test rdi, 1
    jz continue
    mov dword [rsi + 4*rcx], edx
    inc rcx
continue:
    inc rdx
    shr rdi, 1
    jmp loop

end:
    ret
