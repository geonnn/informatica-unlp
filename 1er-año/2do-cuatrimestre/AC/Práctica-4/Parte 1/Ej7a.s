.data
V: .word 1, 2, 36, -7, 25, 5, 18, 56, 12, -10
POS: .word 0
MAX: .word 0

.text

            daddi $t2, $0, V
            daddi $s1, $0, POS ; copio pos para cortar el loop del vector
            dadd $t0, $0, $0
            daddi $s0, $0, -9999 ; inicializo el max.

loop:       ld $t1, 0($t2)
            slt $t4, $t1, $0 ; $t4 = $t1 < $0
            bnez $t4, neg
            daddi $t0, $t0, 1
neg:        nop

            slt $t4, $s0, $t1 ; $t4 = $s0 < $t1
            beqz $t4, esChico
            dadd $s0, $0, $t1
esChico:    nop

            dadd $t1, $t1, $t1
            sd $t1, 0($t2)

            daddi $t2, $t2, 8
            bne $t2, $s1, loop
            sd $t0, POS($0)
            sd $s0, MAX($0)
fin:        halt