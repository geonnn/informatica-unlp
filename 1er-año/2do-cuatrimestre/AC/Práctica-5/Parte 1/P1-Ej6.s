.data
N: .byte 5
result: .word 0
.text
                daddi $sp, $0, 0x400
                lbu $a0, N($0)
                jal factorial
                sd $v0, result($0)
                halt

factorial:      beqz $a0, esCero
                daddi $sp, $sp, -16
                sd $ra, 0($sp)
                sd $a0, 8($sp)

                daddi $a0, $a0, -1
                jal factorial

                ld $ra, 0($sp)
                ld $a0, 8($sp)
                daddi $sp, $sp, 16

                dmul $v0, $v0, $a0
                j fin

esCero:         daddi $v0, $0, 1
fin:            jr $ra
