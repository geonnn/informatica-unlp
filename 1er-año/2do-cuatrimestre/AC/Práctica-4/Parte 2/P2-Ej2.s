.data
ingresar: .asciiz "Ingrese una clave de 4 caracteres ("
restantes: .asciiz " intentos restantes)."
correcta: .asciiz "Clave correcta: acceso permitido."
incorrecta: .asciiz "Clave incorrecta."
clave: .asciiz "XLR8"
CONTROL: .word 0x10000
DATA: .word 0x10008
claveInput: .space 4

.text
                ld $s6, CONTROL($0)
                ld $s7, DATA($0)
                daddi $t5, $0, 5

loopIntento:    daddi $t0, $0, ingresar
                sd $t0, 0($s7) ; DATA recibe puntero a ingresar
                daddi $t0, $0, 4
                sd $t0, 0($s6) ; CONTROL = 4.
                sb $t5, 0($s7) ; DATA recibe intentos restantes
                daddi $t0, $0, 1
                sd $t0, 0($s6) ; CONTROL = 1.
                daddi $t0, $0, restantes
                sd $t0, 0($s7) ; DATA recibe puntero a string restantes
                daddi $t0, $0, 4
                sd $t0, 0($s6) ; CONTROL = 4.

                daddi $t1, $0, claveInput ; puntero clave ingresada.
                daddi $t3, $0, 4 ; contador.
                daddi $t0, $0, 9
loopLeer:       sd $t0, 0($s6) ; CONTROL = 9.
                ld $t2, 0($s7) ; Lee caracter en DATA.
                sb $t2, 0($t1) ; Lo guarda en claveInput.
                daddi $t1, $t1, 1
                daddi $t3, $t3, -1
                bnez $t3, loopLeer

                daddi $t0, $0, clave ; puntero clave almacenada.
                daddi $t1, $0, claveInput ; puntero clave ingresada.
                daddi $t2, $0, 4 ; contador.
loopCheck:      lbu $t3, 0($t0)
                lbu $t4, 0($t1)
                bne $t3, $t4, clIncorrecta
                daddi $t0, $t0, 1
                daddi $t1, $t1, 1
                daddi $t2, $t2, -1
                bnez $t2, loopCheck

                daddi $t0, $0, correcta
                sd $t0, 0($s7)
                daddi $t0, $0, 4
                sd $t0, 0($s6)
                j fin

clIncorrecta:   daddi $t0, $0, incorrecta
                sd $t0, 0($s7)
                daddi $t0, $0, 4
                sd $t0, 0($s6)
                daddi $t5, $t5, -1
                bnez $t5, loopIntento

fin:            halt
