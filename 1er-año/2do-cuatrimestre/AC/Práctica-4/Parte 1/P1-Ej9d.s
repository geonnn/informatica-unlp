.data
hastaCar: .ascii "h"
string: .byte 0

.text
            daddi $t9, $0, string ; pos inicial string.
            daddi $s0, $0, 1 ; contador ocurrencias por letra.
            daddi $t8, $0, 97 ; letra "a"
            lb $s1, hastaCar($0) ; para comparar cuando cortar.

loopString: dadd $t0, $0, $s0 ; copia cuántas veces va una letra.
loopLetra:  sb $t8, 0($t9) ; guarda la letra en memoria.
            daddi $t9, $t9, 1 ; aumenta la posición para guardar el car sig.
            daddi $t0, $t0, -1 ; disminuye las veces que le quedan a esta letra.
            bnez $t0, loopLetra

            daddi $t8, $t8, 1 ; se pasa a la letra siguiente.
            daddi $s0, $s0, 1 ; aumenta las ocurrencias de esa letra.
            bne $t8, $s1, loopString ; loop hasta llegar a la cond. de corte.

            halt