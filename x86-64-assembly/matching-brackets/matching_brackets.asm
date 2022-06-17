section .text
global is_paired
is_paired:
    mov rdx, rsp
    xor rcx, rcx

loop:
    mov al, byte [rdi]

    test al, al
    jz end

    cmp al, '['
    je open
    cmp al, '('
    je open
    cmp al, '{'
    je open
    cmp al, '}'
    je close
    cmp al, ')'
    je close
    cmp al, ']'
    je close

step:
    inc rdi
    jmp loop

end:
    xor rax, rax
    test rcx, rcx
    setz al

return:
    mov rsp, rdx                ; restore old stack
    ret

open:
    inc rcx
    and rax, 0xF0               ; [], () and {} can be grouped by their second
                                ; half-byte
    push rax
    jmp step

close:
    dec rcx
    and rax, 0xF0
    pop rbx
    cmp rax, rbx
    je step

    xor rax, rax
    jmp return
