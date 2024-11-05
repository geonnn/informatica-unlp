.data
cadena: .asciiz "ArquiTectuRa de ComPutaDoras"
LONGITUD: .word 0

.text
            daddi $t0, $0, cadena
            dadd $t1, $0, $0 ; contador
            daddi $s0, $0, 64 ; asigno el número 64 a un reg. para comparaciones

loop:       lb $t2, 0($t0) ; trae la letra del string.
            beqz $t2, fin ; verifica que no sea 0.
            slti $t3, $t2, 90 ; $t3 = $t2 < 91. la "Z" es el 90.
            beqz $t3, noEs ; salta si se pasa de la "Z".
            slt $t3, $s0, $t2 ; $t3 = 64 < $t2. la "A" es el 65.
            beqz $t3, noEs ; salta si no llega a la "A".
            daddi $t1, $t1, 1
noEs:       daddi $t0, $t0, 1
            j loop
fin:        sd $t1, LONGITUD($0)
            halt
