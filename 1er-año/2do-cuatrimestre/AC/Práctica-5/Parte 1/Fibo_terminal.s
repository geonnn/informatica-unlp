.data
CONTROL: .word 0x10000
DATA: .word 0x10008
up: .ascii "w"
left: .ascii "a"
down: .ascii "s"
right: .ascii "d"
.text
                    ld $s6, CONTROL($0)
                    ld $s7, DATA($0)
                    lbu $s0, up($0) 
                    lbu $s1, left($0)
                    lbu $s2, down($0)
                    lbu $s3, right($0)

                    daddi $sp, $0, 0x400
                    dadd $s4, $0, $0

loop:               dadd $a0, $0, $s4
                    jal leerTecla
                    dadd $a0, $0, $v0
                    dadd $s4, $0, $v0
                    jal fibonacci
                    dadd $a0, $0, $v0
                    jal imprimirNum
                    j loop
                    halt


; imprimirNum
; limpia la pantalla previa e imprime otro número.
; recibe número a imprimir por $a0.
imprimirNum:        daddi $t0, $0, 6
                    sd $t0, 0($s6) ; CONTROL = 6. Limpia la pantalla.
                    sd $a0, 0($s7) ; DATA recibe núm a imprimir.
                    daddi $t0, $0, 1
                    sd $t0, 0($s6) ; CONTROL = 1. Imprime núm.
                    jr $ra


; leerTecla
; lee una tecla [wasd](minusc.) como dirección y suma/resta un número x.
; (arriba/derecha = +1).
; (abajo/izquierda = -1).
; recibe x por $a0.
; devuelve x +- 1 por $v0, x <= 0.
leerTecla:          daddi $t0, $0, 9
leerDeNuevo:        sd $t0, 0($s6) ; CONTROL = 9. Lee un car. ascii.
                    ld $t1, 0($s7) ; Carga car. desde DATA.
                    beq $t1, $s0, sumar
                    beq $t1, $s3, sumar
                    beq $t1, $s1, restar
                    beq $t1, $s2, restar
                    j leerDeNuevo

sumar:              daddi $v0, $a0, 1
                    j leerRet

restar:             beqz $a0, leerCero
                    daddi $v0, $a0, -1
                    j leerRet

leerCero:           dadd $v0, $0, $0
leerRet:            jr $ra


; fibonacci(n).
; Devuelve el número en la posición n de la secuencia de fibonacci.
; Recibe n por $a0.
fibonacci:          daddi $t0, $0, 1
                    beqz $a0, fib0
                    beq $a0, $t0, fib1

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

fib0:               dadd $v0, $0, $0
                    j fin

fib1:               daddi $v0, $0, 1
                    j fin

fin:                jr $ra