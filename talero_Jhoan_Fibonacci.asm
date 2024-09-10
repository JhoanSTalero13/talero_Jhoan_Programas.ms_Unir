.data
    prompt:     .asciiz "Ingrese cuantos números de la serie Fibonacci desea: "
    fib_res:    .asciiz "Serie Fibonacci: "
    sum_res:    .asciiz "La suma de la serie es: "

.text
    .globl main
main:
    # Pedir el número de términos de la serie Fibonacci
    li $v0, 4               # Imprimir mensaje
    la $a0, prompt
    syscall

    li $v0, 5               # Leer número de términos
    syscall
    move $t0, $v0           # Guardar el número de términos

    # Inicializar los primeros dos términos de Fibonacci
    li $t1, 0               # F(0)
    li $t2, 1               # F(1)
    li $t3, 0               # Suma de la serie

    # Mostrar mensaje de la serie
    li $v0, 4
    la $a0, fib_res
    syscall

    # Bucle para generar la serie
    li $t4, 0               # Contador de términos generados
fib_loop:
    move $a0, $t1           # Imprimir el término actual
    li $v0, 1
    syscall

    # Sumar el término a la suma total
    add $t3, $t3, $t1

    # Calcular el siguiente término de Fibonacci
    add $t5, $t1, $t2
    move $t1, $t2
    move $t2, $t5

    addi $t4, $t4, 1        # Incrementar el contador
    bne $t4, $t0, fib_loop  # Repetir hasta completar la serie

    # Mostrar la suma de la serie
    li $v0, 4               # Imprimir mensaje
    la $a0, sum_res
    syscall

    move $a0, $t3           # Imprimir la suma
    li $v0, 1
    syscall

    li $v0, 10              # Finalizar el programa
    syscall
