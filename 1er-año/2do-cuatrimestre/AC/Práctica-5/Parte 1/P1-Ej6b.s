.data
N: .byte 5
M: .byte 3
result: .word 0

; comb(m, n) = n! / (m! * (n - m)!)
.text
                    daddi $sp, $0, 0x400
                    lbu $a0, N($0)
                    lbu $a1, M($0)
                    jal comb
                    sd $v0, result($0)
                    halt

comb:               daddi $sp, $sp, -8
                    sd $ra, 0($sp)

                    dadd $s0, $0, $a0 ; s0 = N
                    dadd $s1, $0, $a1 ; s1 = M

                    dsub $a0, $s0, $s1 ; N - M
                    jal factorial
                    dadd $s2, $0, $v0 ; $s2 = (n - m)!

                    dadd $a0, $0, $s0 ; $a0 = n
                    jal factorial
                    dadd $s0, $0, $v0 ; $s0 = n!

                    dadd $a0, $0, $s1 ; $a0 = m
                    jal factorial
                    dadd $s1, $0, $v0 ; $s1 = m!

                    dmul $v0, $s1, $s2
                    ddiv $v0, $s0, $v0

                    ld $ra, 0($sp)
                    daddi $sp, $sp, 8

                    jr $ra

factorial:          dadd $v0, $0, $a0
loopFact:           daddi $a0, $a0, -1
                    beqz $a0, fin
                    dmul $v0, $v0, $a0
                    j loopFact
fin:                jr $ra
