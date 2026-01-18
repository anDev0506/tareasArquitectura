.data
	arr: .word 8 1 6 4 7 3 5 2 9   # Arreglo a ordenar

.text
	main:
	la $a0, arr          # $a0 = dirección base del arreglo
	li $a1, 9            # $a1 = tamaño del arreglo
	
	jal bbsi             # Llama a bbsi(arr, n) → Bubble Sort mejorado
	jal prnt             # Imprime el arreglo ordenado
	
	li $v0, 10           # Salir del programa
	syscall
	
	
	
	########################
	# bbsi(arr, n)
	# $a0 = dirección del arreglo
	# $a1 = tamaño del arreglo
	# Implementa Bubble Sort con bandera de optimización
	########################
	bbsi:
	addi $sp, $sp, -12   # Reserva espacio en la pila
	sw $a1, 12($sp)      # Guarda n
	sw $a2, 4($sp)       # Guarda i
	sw $a3, 0($sp)       # Guarda j
	
	subi $a1, $a1, 1     # a1 = n - 1 (límite superior)
	li $a2, 0            # i = 0 → iterador externo
	
	for1:                # for (i = 0; i < n-1; i++)
	li $a3, 0            # j = 0 → iterador interno
	li $t0, 0            # bandera = 0 (indica si hubo intercambio)
	sub $t1, $a1, $a2    # t1 = (n-1) - i → límite del for interno
	
	for2:                # for (j = 0; j < n-i-1; j++)
	addi $t4, $a3, 1     # t4 = j + 1
	sll $t2, $a3, 2
	add $t2, $t2, $a0    # Dirección de arr[j]
	lw $t3, 0($t2)       # t3 = arr[j]
	
	sll $t4, $t4, 2
	add $t4, $t4, $a0    # Dirección de arr[j+1]
	lw $t5, 0($t4)       # t5 = arr[j+1]
	
	bgt $t3, $t5, if     # Si arr[j] > arr[j+1], ir a if (intercambio)
	j endif
	
	if:
	sw $t5, 0($t2)       # arr[j] = arr[j+1]
	sw $t3, 0($t4)       # arr[j+1] = arr[j]
	li $t0, 1            # bandera = 1 (hubo intercambio)
	
	endif:
	addi $a3, $a3, 1     # j++
	blt $a3, $t1, for2   # Mientras j < n-i-1
	 
	beq $t0, 0, end      # Si no hubo intercambios, el arreglo ya está ordenado
	addi $a2, $a2, 1     # i++
	blt $a2, $a1, for1   # Mientras i < n-1
	
	end:
	lw $a3, 0($sp)       # Restaurar j
	lw $a2, 4($sp)       # Restaurar i
	lw $a1, 12($sp)      # Restaurar n
	addi $sp, $sp, 12    # Liberar pila
	jr $ra               # Retorna



	########################
	# prnt(arr, n)
	# Imprime el arreglo
	########################
	prnt:
	addi $sp, $sp, -8    # Reserva espacio en pila
	sw $ra, 4($sp)       # Guarda $ra
	sw $a0, 0($sp)       # Guarda dirección del arreglo
	
	li $t0, 0            # i = 0
	while:
	sll $t1, $t0, 2      # t1 = i * 4
	add $t2, $t1, $a0    # Dirección de arr[i]
	
	lw $a0, 0($t2)       # Cargar arr[i]
	li $v0, 1            # Syscall imprimir entero
	syscall
	
	lw $a0, 0($sp)       # Restaurar dirección base
	addi $t0, $t0, 1     # i++
	blt $t0, $a1, while  # Mientras i < n
	
	lw $ra, 4($sp)       # Restaurar $ra
	addi $sp, $sp, 8     # Liberar pila
	jr $ra               # Retorna