.data
V: .word 10, 20, 15, 12, 8, 7, 87, 56, 17, 48
W: .word 0

.text
            daddi $t1, $0, V
            daddi $t2, $0, W
            daddi $s0, $0, W
loop:       ld $t0, 0($t1)
            andi $t3, $t0, 1
            beqz $t3, esPar
            sd $t0, 0($t2)
            daddi $t2, $t2, 8
esPar:      daddi $t1, $t1, 8
            bne $t1, $s0, loop
            halt
