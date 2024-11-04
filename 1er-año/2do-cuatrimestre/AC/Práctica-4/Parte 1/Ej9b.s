.data
cadena: .asciiz "adbdcdedfdgdhdid" ; cadena a analizar
car: .ascii "d" ; carácter buscado
cant: .word 0 ; cantidad de veces que se repite el carácter car en cadena.

.text
            daddi $t0, $0, cadena
            dadd $t1, $0, $0 ; contador
            ld $s0, car($0) ; caracter buscado

loop:       lb $t2, 0($t0)
            beqz $t2, fin
            bne $t2, $s0, noEsElCar
            daddi $t1, $t1, 1
noEsElCar:  daddi $t0, $t0, 1
            j loop
fin:        sd $t1, cant($0)
            halt
