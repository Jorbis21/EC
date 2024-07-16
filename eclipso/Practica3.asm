@Javier Orbis Ramirez Y Samuel Asanza Mesa
.global start
.equ N,8
.data
A: .word 7,3,25,4,75,2,1,1
.bss
B: .space N*4
.text
start:
   mov fp, #0
   LDR R1,=A
   LDR R2,=B
   MOV R3,#N
   MOV R4,#0
FOR:
   CMP R4,R3
   BGE LLAMADA
   BL MAX
   LDR R6,[R1,R5,LSL#2]
   STR R6,[R2,R4,LSL#2]
   MOV R6,#0
   STR R6,[R1,R5,LSL#2]
   ADD R4,R4,#1
   b FOR
LLAMADA:
	ldr r1,=A
	ldr r0,=B
	MOV r2, #N
	bl invertir
	b FIN
MAX:
   push {r6-r10,fp,lr}
   add fp, sp, #24 @ 24=4*7-4
   MOV R6,#0
   MOV R7,#0
   MOV R8,#0
   MOV R9,R3
   MOV R10,R1
FOR2:
   CMP R8,R9
   BGE FINFOR2
   LDR R5,[R10,R8,LSL #2]
IF:
   CMP R5,R6
   BLT FINIF
   MOV R6,R5
   MOV R7,R8
FINIF:
   ADD R8,R8,#1
   B FOR2
FINFOR2:
	MOV R5,R7
    pop {r6-r10,fp,lr}
    MOV PC,LR
invertir:
	push {r4,r5}
	mov r3,#0
	mov r5,r2
loop_i:
	cmp r3,r2
	bge fin_inv
	ldr r4,[r0,r3,lsl #2]
	sub r5,r5,#1
	push {r0,r1,lr}
	mov r0, r4
	bl espar
	mov r6, r0
	pop {r0,r1,lr}
	str r6,[r1,r5,lsl #2]
	add r3, r3, #1
	b loop_i
fin_inv:
	pop {r4,r5}
	mov pc, lr
espar:
	and r1,r0,#1
	cmp r1,#0
	bne fin_espar
	mov r0,#0
fin_espar:
	mov pc,lr
FIN: B .
.END
