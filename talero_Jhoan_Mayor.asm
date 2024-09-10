.data
    prompt1:   .asciiz "Ingrese el n�mero de valores (3 a 5): "
    prompt2:   .asciiz "Ingrese un n�mero: "
    result:    .asciiz "El n�mero mayor es: "

.text
    .globl main
main:
    # Pedir al usuario cu�ntos n�meros comparar
    li $v0, 4               # System call para imprimir cadena
    la $a0, prompt1          # Cargar direcci�n del mensaje
    syscall

    li $v0, 5               # System call para leer entero
    syscall
    move $t0, $v0           # Guardar el n�mero de valores (3-5)

    # Inicializar el mayor
    li $t1, -2147483648      # Valor inicial de menor posible para el mayor

    # Bucle para leer los n�meros
    li $t2, 0               # Contador de n�meros le�dos
read_loop:
    li $v0, 4               # Imprimir mensaje de entrada
    la $a0, prompt2
    syscall

    li $v0, 5               # Leer n�mero
    syscall
    move $t3, $v0           # Guardar el n�mero le�do

    # Comparar con el mayor actual
    ble $t1, $t3, update_max
    j next

update_max:
    move $t1, $t3           # Actualizar el mayor

next:
    addi $t2, $t2, 1        # Incrementar el contador
    bne $t2, $t0, read_loop # Repetir hasta leer todos los n�meros

    # Mostrar el resultado
    li $v0, 4               # System call para imprimir cadena
    la $a0, result
    syscall

    move $a0, $t1           # Mover el mayor a $a0
    li $v0, 1               # System call para imprimir entero
    syscall

    li $v0, 10              # Finalizar el programa
    syscall
