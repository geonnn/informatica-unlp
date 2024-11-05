.data
V: .word 0

.text
        daddi $t0, $0, V
        daddi $t1, $0, 10
        daddi $t2, $0, 1
loop:   sd $t2, 0($t0)
        daddi $t1, $t1, -1
        daddi $t0, $t0, 8
        daddi $t2, $t2, 2
        bnez $t1, loop
        halt
