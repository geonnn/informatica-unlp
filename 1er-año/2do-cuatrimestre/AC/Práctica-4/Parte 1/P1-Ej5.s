.data
A: .word 6
B: .word 10
C: .word 0
S: .word 0
P: .word 0
D: .word 0
F: .word 0
N: .word 4
L: .word 0

.code

; a

ld $s0, A($0) ; $s0 = A
ld $s1, B($0) ; $s1 = B
dadd $t0, $s0, $s1 ; $t0 = A + B
dmul $t1, $s0, $s1 ; $t1 = A * B
dmul $t2, $s0, $s0 ; $t2 = A^2
sd $t0, S($0) ; S = $t0
daddi $t0, $t1, 2 ; $t0 = $t1 + 2
ddiv $t2, $t2, $s1 ; $t2 = $t2 / B
sd $t0, P($0) ; P = $t0
sd $t2, D($0) ; D = $t2

; b

        beqz $s0, esCero
        slt $t0, $s1, $s0 ; $t0 = 1 si B < A, sino $t0 = 0.
        bnez $t0, AMQueB
        sd $s1, C($0) ; C = B
        j finB
AMQueB: dadd $t0, $s0, $s0 ; $t0 = A * 2
        sd $t0, C($0) ; C = A * 2
        j finB
esCero: sd $0, C($0) ; C = 0
finB:   nop   

; c

        ld $t0, N($0) ; $t0 = N
        daddi $t1, $0, 1 ; $t1 = 1
loopC:  dmul $t1, $t1, $t0 ; $t1 = $t1 * N
        daddi $t0, $t0, -1 ; N = N - 1
        bnez $t0, loopC
        sd $t1, F($0) ; F = $t1

; d

        ld $t0, N($0) ; $t0 = N
        daddi $t1, $0, 2 ; $t1 = 2
        daddi $t2, $0, -1 ; $t2 = -1, (L += 1 siempre se hace una vez más)
loopD:  ddiv $t0, $t0, $t1 ; N = N / 2
        daddi $t2, $t2, 1 ; $t2 = $t2 + 1
        slt $t3, $0, $t0 ; $t3 boolean = 0 < N
        bnez $t3, loopD ; salta si $t3 =/= 0
        sd $t2, L($0) ; L = $t2

; e

        andi $t0, $s0, 1
        beqz $t0, esPar
        sd $t0, B($0)
        j finE
esPar:  sd $0, B($0)
finE:   nop
halt