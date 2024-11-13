.data
base: .word 5
exponente: .word 4
result: .word 0
CONTROL: .word 0x10000
DATA: .word 0x10008
.code
                daddi $sp, $0, 0x400
                daddi $t0, $0, base
                daddi $t1, $0, exponente
                daddi $sp, $sp, -16
                sd $t0, 0($sp)
                sd $t1, 8($sp)
                jal potencia
                ld $t0, 0($sp)
                ld $t1, 8($sp)
                daddi $sp, $sp, 16
                sd $v0, result($zero)

                ld $s6, CONTROL($0)
                ld $s7, DATA($0)

                daddi $t0, $0, 2
                sd $v0, 0($s7)
                sd $t0, 0($s6)
                halt

potencia:       daddi $v0, $zero, 1
                
                ld $t0, 0($sp) ; dir.
                ld $t1, 8($sp) ; dir.

                ld $a0, 0($t0) ; valor
                ld $a1, 0($t1) ; valor
lazo:           beqz $a1, terminar
                daddi $a1, $a1, -1
                dmul $v0, $v0, $a0
                j lazo
terminar:       jr $ra