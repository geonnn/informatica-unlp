.data
base: .word 5
exponente: .word 4
result: .word 0
CONTROL: .word 0x10000
DATA: .word 0x10008
.code
                ld $a0, base($zero)
                ld $a1, exponente($zero)
                jal potencia
                sd $v0, result($zero)

                ld $s6, CONTROL($0)
                ld $s7, DATA($0)

                daddi $t0, $0, 2
                sd $v0, 0($s7)
                sd $t0, 0($s6)
                halt

potencia:       daddi $v0, $zero, 1
lazo:           beqz $a1, terminar
                daddi $a1, $a1, -1
                dmul $v0, $v0, $a0
                j lazo
terminar:       jr $ra