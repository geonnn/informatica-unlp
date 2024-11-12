.data
coorX: .byte 24 ; coordenada X de un punto
coorY: .byte 24 ; coordenada Y de un punto
color: .byte 0, 0, 0, 0 ; color: máximo rojo + máximo azul  magenta
CONTROL: .word 0x10000
DATA: .word 0x10008
.code
            ld $s6, CONTROL($zero) ; $s6 = dirección de CONTROL
            ld $s7, DATA($zero) ; $s7 = dirección de DATA

            
            daddi $t0, $0, 8
            sd $t0, 0($s6) ; CONTROL recibe 8
            lbu $t1, 0($s7)
            sd $t0, 0($s6) ; CONTROL recibe 8
            lbu $t2, 0($s7)

            lwu $t3, color($zero) ; $t3 = valor de color a pintar (4 bytes)
loopPintar: sw $t3, 0($s7) ; DATA recibe el valor del color a pintar

            sb $t1, 5($s7) ; DATA+5 recibe el valor de coordenada X
            sb $t2, 4($s7) ; DATA+4 recibe el valor de coordenada Y

            daddi $t4, $zero, 5 ; $t4 = 5  función 5 salida gráfca
            sd $t4, 0($s6) ; CONTROL recibe 5 y produce el dibujo del punto
            
            daddi $t5, $0, 255
            daddi $t3, $t3, 1
            bne $t3, $t5, loopPintar


            halt