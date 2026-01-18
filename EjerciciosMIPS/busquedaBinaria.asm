.data
	arr: .word 1 2 3 5 8 13 21   # Arreglo ordenado donde se hará la búsqueda

.text
	main:
	la $a0, arr          # $a0 = dirección base del arreglo
	li $a1, 0            # $a1 = índice inicial (low)
	li $a2, 7            # $a2 = tamaño del arreglo (high exclusivo)
	li $a3, 9            # $a3 = elemento a buscar
	
	jal bus_bin          # Llama a bus_bin(arr, low, high, key)
	
	move $a0, $v0        # Resultado devuelto (posición o -1)
	li $v0, 1            # Syscall para imprimir entero
	syscall
	
	li $v0, 10           # Salir del programa
	syscall



	########################
	# bus_bin(arr, low, high, key)
	# $a0 = dirección del arreglo
	# $a1 = índice inicial
	# $a2 = tamaño del arreglo
	# $a3 = elemento a buscar
	# Retorna en $v0 la posición o -1 si no se encuentra
	########################
	bus_bin:
	addi $sp, $sp, -8    # Reserva espacio en la pila
	sw $a1, 4($sp)       # Guarda low
	sw $a2, 0($sp)       # Guarda high
	
	while:               # while (low <= high)
	add $t0, $a1, $a2    # t0 = low + high
	div $t0, $t0, 2      # t0 = (low + high) / 2 → índice medio
	sll $t1, $t0, 2      # t1 = mid * 4 (offset en bytes)
	add $t2, $a0, $t1    # Dirección de arr[mid]
	lw $t3, 0($t2)       # t3 = arr[mid]
	beq $t3, $a3, end    # Si arr[mid] == key, salir
	bgt $a1, $a2, end    # Si low > high, salir (no encontrado)
	blt $t3, $a3, else   # Si arr[mid] < key, ir al else
	
	if:                  # Si arr[mid] > key
	move $a2, $t0        # high = mid
	subi $a2, $a2, 1     # high = mid - 1
	j while
	
	else:                # Si arr[mid] < key
	move $a1, $t0        # low = mid
	addi $a1, $a1, 1     # low = mid + 1
	j while
	
	end:
	lw $a2, 0($sp)       # Restaura high original
	lw $a1, 4($sp)       # Restaura low original
	addi $sp, $sp, 8     # Libera pila
	
	beq $a3, $t3, ok     # Si se encontró el elemento, ir a ok
	
	error:               # Si no se encontró
	li $v0, -1           # Retorna -1
	jr $ra
	
	ok:
	move $v0, $t0        # Retorna la posición encontrada
	jr $ra