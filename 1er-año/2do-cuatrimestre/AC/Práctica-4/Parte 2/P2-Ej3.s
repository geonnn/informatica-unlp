.data
CONTROL: .word 0x10000
DATA: .word 0x10008
suma: .ascii "+"
resta: .ascii "-"
mul: .ascii "*"
div: .ascii "/"

.text

                ld $s6, CONTROL($0)
                ld $s7, DATA($0)
                ld $s0, suma($0)
                ld $s1, resta($0)
                ld $s2, mul($0)
                ld $s3, div($0)

                daddi $t0, $0, 8
                sd $t0, 0($s6)
                ld $t1, 0($s7)

loopCalc:       daddi $t0, $0, 9
                sd $t0, 0($s6)
                ld $t0, 0($s7)

                daddi $t4, $0, 8
                sd $t4, 0($s6)
                ld $t2, 0($s7)

                bne $t0, $s0, noEsSuma
                dadd $t3, $t1, $t2
                j fin

noEsSuma:       bne $t0, $s1, noEsResta
                dsub $t3, $t1, $t2
                j fin

noEsResta:      bne $t0, $s2, noEsMul
                dmul $t3, $t1, $t2
                j fin

noEsMul:        ddiv $t3, $t1, $t2

fin:            daddi $t0, $0, 2 
                sd $t3, 0($s7)
                sd $t0, 0($s6)
                dadd $t1, $t3, $0
                j loopCalc
                halt
