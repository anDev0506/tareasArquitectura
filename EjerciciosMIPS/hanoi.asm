.data
	msg1: .asciiz "Se movio el disco "   # Texto inicial del mensaje
	msg2: .asciiz " desde la torre "    # Texto intermedio del mensaje
	msg3: .asciiz " a la torre "        # Texto final del mensaje
	endln: .asciiz "\n"                 # Salto de línea

.text
	main:
	li $a0, 3            # $a0 = número de discos
	li $a1, 1            # $a1 = torre origen
	li $a2, 3            # $a2 = torre destino
	li $a3, 2            # $a3 = torre auxiliar
		
	jal hanoi            # Llama a hanoi(n, origen, destino, auxiliar)
	
	li $v0, 10           # Salir del programa
	syscall
	
	
	
	########################
	# hanoi(n, origen, destino, auxiliar)
	# $a0 = número de discos
	# $a1 = torre origen
	# $a2 = torre destino
	# $a3 = torre auxiliar
	# Imprime cada movimiento
	########################
	hanoi:
	bnez $a0, recur      # Si n != 0, ir a recur
	jr $ra               # Si n == 0, retornar
	
	recur:
	addi $sp, $sp, -20   # Reserva espacio en la pila
	sw $ra, 16($sp)      # Guarda dirección de retorno
	sw $a0, 12($sp)      # Guarda n
	sw $a1, 8($sp)       # Guarda origen
	sw $a2, 4($sp)       # Guarda destino
	sw $a3, 0($sp)       # Guarda auxiliar
	
	# Primera llamada recursiva: mover n-1 discos al auxiliar
	subi $a0, $a0, 1     # n = n - 1
	move $a3, $a2        # nuevo auxiliar = destino
	lw $a2, 0($sp)       # nuevo destino = auxiliar original
	jal hanoi            # hanoi(n-1, origen, auxiliar, destino)
	
	move $t0, $a0        # Guarda n-1 en t0
	
	# Imprimir movimiento del disco n
	la $a0, msg1
	li $v0, 4
	syscall              # Imprime "Se movio el disco "
	
	addi $a0, $t0, 1     # Imprime número de disco (n)
	li $v0, 1
	syscall
	
	la $a0, msg2
	li $v0, 4
	syscall              # Imprime " desde la torre "
	
	move $a0, $a1        # Imprime torre origen
	li $v0, 1
	syscall
	
	la $a0, msg3
	li $v0, 4
	syscall              # Imprime " a la torre "
	
	move $a0, $a3        # Imprime torre destino
	li $v0, 1
	syscall
	
	la $a0, endln
	li $v0, 4
	syscall              # Salto de línea
	
	# Segunda llamada recursiva: mover n-1 discos al destino
	move $a0, $t0        # n = n - 1
	move $a2, $a3        # nuevo destino = destino real
	move $a3, $a1        # nuevo auxiliar = origen
	lw $a1, 0($sp)       # restaurar origen original
	jal hanoi            # hanoi(n-1, auxiliar, destino, origen)
	
	# Restaurar registros
	lw $a3, 0($sp)
	lw $a2, 4($sp)
	lw $a1, 8($sp)
	lw $a0, 12($sp)
	lw $ra, 16($sp)
	addi $sp, $sp, 20
	jr $ra