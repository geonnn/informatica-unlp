.data
string: .asciiz "hola"
car: .ascii "h"
long: .word 0

.text
                    daddi $a0, $0, string
                    ld $a1, car($0)
                    jal contiene
                    sd $v0, long($0)
                    halt

; longitud
; Recibe en $a0 la dirección de un string. - Asumo que es un asciiz, terminado en 0.
; Retorna su longitud en $v0. 
longitud:           dadd $v0, $0, $0
loopLong:           lbu $t1, 0($a0)
                    beqz $t1, finString
                    daddi $v0, $v0, 1
                    daddi $a0, $a0, 1
                    j loopLong
finString:          jr $ra

; contiene
; Recibe en $a0 la dirección de un string.
; en $a1 un caracter (código ascii). 
; Devuelve en $v0 1 si el string contiene el caracter $a1 y 0 de lo contrario.
contiene:           dadd $v0, $0, $0
loopContiene:       lbu $t0, 0($a0)
                    beqz $t0, finContiene
                    beq $t0, $a1, found
                    daddi $a0, $a0, 1
                    j loopContiene
found:              daddi $v0, $0, 1
finContiene:        jr $ra

; esVocal
; Determina si un caracter es vocal o no, ya sea mayúscula o minúscula. 
; Retorna el valor 1 si es una vocal ó 0 en caso contrario.
; Para implementar esVocal, utilizar la subrutina contiene.
esVocal:            dadd $t0, $0, $0
                    daddi $t0, $0, 1
                    jr $ra