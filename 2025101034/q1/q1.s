.data
fmt_scan:  .string "%lld"
fmt_print: .string "%lld\n"
n:   .dword 0
val: .dword 0

.global main
main:
    addi sp, sp, -48
    sd ra, 40(sp)
    sd s0, 32(sp)
    sd s1, 24(sp)
    sd s2, 16(sp)
    sd s3, 8(sp)

    la a0, fmt_scan
    la a1, n
    call scanf
    ld s0, n              # s0 = n

    li s1, -2147483648    # s1 = max
    li s2, -2147483648    # s2 = second_max
    li s3, 0              # s3 = counter

loop:
    bge s3, s0, done
    la a0, fmt_scan
    la a1, val
    call scanf
    ld t0, val

    ble t0, s1, check_second
    mv s2, s1             # second_max = old max
    mv s1, t0             # max = new value
    addi s3, s3, 1
    j loop

check_second:
    beq t0, s1, skip      # skip if equal to max
    ble t0, s2, skip      # skip if <= second_max
    mv s2, t0             # update second_max

skip:
    addi s3, s3, 1
    j loop

done:
    la a0, fmt_print
    mv a1, s2
    call printf

    ld ra, 40(sp)
    ld s0, 32(sp)
    ld s1, 24(sp)
    ld s2, 16(sp)
    ld s3, 8(sp)
    addi sp, sp, 48
    li a0, 0
    ret
