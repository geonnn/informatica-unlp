.data
V: .word 0

.text
        daddi $t0, $0, V
        daddi $t1, $0, 8 ; arranca con el 0 y el 1 como primeros dos elementos
        daddi $t2, $0, 1
        daddi $t0, $t0, 8
        sd $t2, 0($t0) ; guardo el 1 en la pos 2
loop:   ld $t3, -8($t0)
        ld $t4, 0($t0)
        dadd $t2, $t3, $t4
        daddi $t0, $t0, 8
        daddi $t1, $t1, -1
        sd $t2, 0($t0)
        bnez $t1, loop
        halt
