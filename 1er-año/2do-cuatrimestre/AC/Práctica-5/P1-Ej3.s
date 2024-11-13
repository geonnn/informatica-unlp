; intercambiar valores de t1 y t0 por la pila.
.code
daddi $sp, $0, 0x400
daddi $t0, $0, 5
daddi $t1, $0, 8
daddi $sp, $sp, -16
sd $t0, 0($sp)  ; push $t0
sd $t1, 8($sp)  ; push $t1
ld $t0, 8($sp)  ; pop $t0
ld $t1, 0($sp)  ; pop $t1
daddi $sp, $sp, 16
halt