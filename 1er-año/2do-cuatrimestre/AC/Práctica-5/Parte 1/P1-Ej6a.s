.data
N: .byte 5
result: .word 0

.text
                    lbu $a0, N($0)
                    jal factorial
                    sd $v0, result($0)
                    halt

factorial:          dadd $v0, $0, $a0
loopFact:           daddi $a0, $a0, -1
                    beqz $a0, fin
                    dmul $v0, $v0, $a0
                    j loopFact
fin:                jr $ra
