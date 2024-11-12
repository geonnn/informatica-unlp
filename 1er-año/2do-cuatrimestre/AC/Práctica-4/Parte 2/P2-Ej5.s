.data
X: .byte 0
Y: .byte 45
color: .byte 255, 0, 0, 0
CONTROL: .word32 0x10000
DATA: .word32 0x10008
.code
                lwu $s6, CONTROL($zero)
                lwu $s7, DATA($zero)
                lwu $t0, color($zero)
                sw $t0, 0($s7)

                lbu $t1,Y($zero)
                lbu $t2,X($zero)
                daddi $t4,$zero,5
                daddi $t5,$zero,50

loop:           sb $t1,4($s7) ; coord y
                sb $t2,5($s7) ; coord x

                daddi $t3, $zero, 5
                sd $t3,0($s6) ; control = 5
                daddi $t2, $t2, 1
                bne $t2,$t4,loop

                lbu $t2, X($0)
                daddi $t1,$t1,1
                bne $t5, $t1, loop
                halt