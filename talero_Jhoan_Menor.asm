.data
    prompt1:   .asciiz "Ingrese el número de valores (3 a 5): "
    prompt2:   .asciiz "Ingrese un número: "
    result:    .asciiz "El número menor es: "

.text
    .globl main
main:
    # Pedir al usuario cuántos números comparar
    li $v0, 4               # System call para imprimir cadena
    la $a0, prompt1          # Cargar dirección del mensaje
    syscall

    li $v0, 5               # System call para leer entero
    syscall
    move $t0, $v0           # Guardar el número de valores (3-5)

    # Inicializar el menor
    li $t1, 2147483647       # Valor inicial de mayor posible para el menor

    # Bucle para leer los números
    li $t2, 0               # Contador de números leídos
read_loop:
    li $v0, 4               # Imprimir mensaje de entrada
    la $a0, prompt2
    syscall

    li $v0, 5               # Leer número
    syscall
    move $t3, $v0           # Guardar el número leído

    # Comparar con el menor actual
    bge $t1, $t3, update_min
    j next

update_min:
    move $t1, $t3           # Actualizar el menor

next:
    addi $t2, $t2, 1        # Incrementar el contador
    bne $t2, $t0, read_loop # Repetir hasta leer todos los números

    # Mostrar el resultado
    li $v0, 4               # System call para imprimir cadena
    la $a0, result
    syscall

    move $a0, $t1           # Mover el menor a $a0
    li $v0, 1               # System call para imprimir entero
    syscall

    li $v0, 10              # Finalizar el programa
    syscall
