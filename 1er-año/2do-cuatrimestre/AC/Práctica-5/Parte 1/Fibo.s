.data
N: .byte 7
result: .word 0

.text
                    daddi $sp, $0, 0x400
                    lbu $a0, N($0)
                    jal fibonacci
                    sd $v0, result($0)
                    halt

fibonacci:          daddi $t0, $0, 1
                    beqz $a0, esCero
                    beq $a0, $t0, esUno

                    daddi $sp, $sp, -24

                    sd $ra, 0($sp)
                    sd $a0, 8($sp)
                    daddi $a0, $a0, -1
                    jal fibonacci
                    sd $v0, 16($sp) ; guardo fib(n-1) en la pila.

                    ld $a0, 8($sp) ; restuaro $a0 para fib(n-2)
                    daddi $a0, $a0, -2
                    jal fibonacci

                    ld $ra, 0($sp) ; restauro $r0.
                    ld $a0, 8($sp) ; restauro $a0.
                    ld $t1, 16($sp) ; cargo fib(n-1)
                    daddi $sp, $sp, 24 ; restauro $sp.

                    dadd $v0, $t1, $v0 ; fib(n-1) + fib(n-2)
                    j fin

esCero:             dadd $v0, $0, $0
                    j fin

esUno:              daddi $v0, $0, 1
                    j fin

fin:                jr $ra