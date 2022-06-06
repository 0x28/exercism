default rel

section .rodata
age_table: dd 0.2408467,0.61519726,1.0,1.8808158,11.862615,29.447498,84.016846,164.79132,0
year: dd 31557600.0

section .text
global age
age:
    cvtsi2ss xmm0, rsi
    movss xmm2, [year]
    lea rbx, [age_table]
    movss xmm1, [rbx + 4 * rdi]
    divss xmm0, xmm1
    divss xmm0, xmm2
    ret
