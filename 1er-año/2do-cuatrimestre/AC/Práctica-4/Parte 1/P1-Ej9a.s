.data
cadena: .asciiz "ArquiTectuRa de ComPutaDoras"
LONGITUD: .word 0

.text
            daddi $t0, $0, cadena
            dadd $t1, $0, $0 ; contador

loop:       lb $t2, 0($t0)
            beqz $t2, fin
            daddi $t1, $t1, 1
            daddi $t0, $t0, 1
            j loop
fin:        sd $t1, LONGITUD($0)
            halt
