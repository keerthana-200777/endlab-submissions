.data
fmt_scan:  .string "%lld"
fmt_true:  .string "TRUE\n"
fmt_false: .string "FALSE\n"
n: .dword 0

.global main
main:
    addi sp, sp, -32
    sd ra, 24(sp)
    sd s0, 16(sp)
    sd s1, 8(sp)

    la a0, fmt_scan
    la a1, n
    call scanf

    ld s0, n
    li t0, 10
    li t1, 0
    mv t2, s0

digit_cnt:
    ble t2, zero, count_done
    div t2, t2, t0
    addi t1, t1, 1
    j digit_cnt

count_done:
    li s1, 0
    mv t2, s0

loop:
    ble t2, zero, check
    rem t3, t2, t0
    div t2, t2, t0
    li t4, 1
    mv t5, t1

power_loop:
    ble t5, zero, power_done
    mul t4, t4, t3
    addi t5, t5, -1
    j power_loop

power_done:
    add s1, s1, t4
    addi t1, t1, -1
    j loop

check:
    bne s1, s0, print_false
    la a0, fmt_true
    call printf
    j end

print_false:
    la a0, fmt_false
    call printf

end:
    ld ra, 24(sp)
    ld s0, 16(sp)
    ld s1, 8(sp)
    addi sp, sp, 32
    li a0, 0
    ret
