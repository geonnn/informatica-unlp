.data
V: .word32 5, 2, 6

.text

; a)

; ld $t1, V($0)
; daddi $t2, $0, 8
; dadd $t0, $0, $t1
; ld $t1, V($t2)
; daddi $t2, $t2, 8
; dadd $t0, $t0, $t1
; ld $t1, V($t2)
; dadd $t0, $t0, $t1
; ----------------------------------------

; b)

        dadd $t2, $0, $0
        dadd $t0, $0, $0
loop:   lw $t1, V($t2)
        beqz $t1, fin
        dadd $t0, $t0, $t1
        daddi $t2, $t2, 4
        j loop
fin:    nop
; ----------------------------------------

; c)

;         daddi $t2, $0, V
;         dadd $t0, $0, $0
; loop:   ld $t1, 0($t2)
;         beqz $t1, fin
;         dadd $t0, $t0, $t1
;         daddi $t2, $t2, 8
;         j loop
; fin:    nop
halt