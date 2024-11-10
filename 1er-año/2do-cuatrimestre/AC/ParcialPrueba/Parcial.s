.data
X: .space 10
Y: .space 10
cantCoord: .word 10
CONTROL: .word 0x10000
DATA: .word 0x10008
rojo: .byte 255, 0, 0, 0

.text
                    ld $s6, CONTROL($0) ; $s6 = dir. CONTROL.
                    ld $s7, DATA($0) ; $s7 = dir. DATA.
                    daddi $sp, $0, 0x400 ; Inicializar sp.
                    daddi $a0, $0, X ; Dir. vector X.
                    ld $a1, cantCoord($0) ; Cant. coords a leer.
                    jal leerCoordenadas
                    daddi $a0, $0, Y ; Dir. vector Y.
                    ld $a1, cantCoord($0) ; Cant. coords a leer.
                    jal leerCoordenadas
                    daddi $a0, $0, X
                    daddi $a1, $0, Y
                    ld $a2, cantCoord($0)
                    jal pintarRojo
                    halt


leerCoordenadas:    daddi $sp, $sp, -32
                    sd $ra, 0($sp)
                    sd $s0, 8($sp)
                    sd $s1, 16($sp)
                    sd $s2, 24($sp)
                    dadd $s0, $0, $a0 ; Dir. vector X.
                    dadd $s1, $0, $a1 ; Contador cant de coords a leer.
                    beqz $a1, lCFin

lCloop:             daddi $t0, $0, 8 ; para escribir en CONTROL.
                    sd $t0, 0($s6) ; CONTROL = 8.
                    ld $s2, 0($s7) ; $a0 = coord leída en DATA.
                    dadd $a0, $0, $s2 ; Coord. a verificar.
                    dadd $a1, $0, $0 ; Valor A.
                    daddi $a2, $0, 49 ; Valor B.
                    jal entre
                    beqz $v0, lCloop ; $v0 = 0 coord. inválida.
                    sb $s2, 0($s0) ; Guarda la coord. en el vector.
                    daddi $s0, $s0, 1 ; Aumenta puntero del vector.
                    daddi $s1, $s1, -1 ; Disminuye contador.
                    bnez $s1, lCloop
lCFin:              ld $ra, 0($sp)
                    ld $s0, 8($sp)
                    ld $s1, 16($sp)
                    ld $s2, 24($sp)
                    daddi $sp, $sp, 32
                    jr $ra

entre:              daddi $t0, $a1, -1 ; para incluir $a1 la cmp va a ser a1-1 < valor
                    daddi $t1, $a2, 1 ; para incluir $a2 la cmp va a ser valor < $a2+1
                    slt $t2, $t0, $a0 ; $t2 = $a1 <= $a0.
                    beqz $t2, coordInvalida
                    slt $t2, $a0, $t1 ; $t2 = $a0 <= $a2
                    beqz $t2, coordInvalida
                    daddi $v0, $0, 1
                    jr $ra
coordInvalida:      dadd $v0, $0, $0
                    jr $ra

pintarRojo:         lwu $t0, rojo($0) ; cargo el rojo en $t0
                    sw $t0, 0($s7) ; cargo el rojo en DATA.
loopPintar:         lbu $t0, 0($a0) ; $t0 = coord. X
                    sb $t0, 5($s7) ; cargo coord X en DATA+5.
                    lbu $t0, 0($a1) ; $t0 = coord. Y
                    sb $t0, 4($s7) ; cargo coord Y en DATA+4.
                    daddi $t0, $0, 5 ; para escribir en CONTROL.
                    sd $t0, 0($s6) ; CONTROL = 5.
                    daddi $a0, $a0, 1 ; aumento puntero vector X.
                    daddi $a1, $a1, 1 ; aumento puntero vector Y.
                    daddi $a2, $a2, -1 ; disminuyo contador.
                    bnez $a2, loopPintar
                    jr $ra
                    