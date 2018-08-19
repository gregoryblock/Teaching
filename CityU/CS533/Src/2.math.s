## Enter two integers in console window
## Sum is displayed
        .data
		val1: .word 76
		val2: .word 457
		name:  .asciiz "Hello World! My name is Chieko Dean \n"
		lbl1:  .asciiz "First number is: "
		lbl2:  .asciiz "\nSecond number is: "
		sum1:  .asciiz "\nThe sum is: "

        .text
        .globl main
main:   li $v0, 4			## print name (string) on console
        la $a0, name    
        syscall         
    
		lw $t1, val1		## load the two constants (integers) into registers
		lw $t2, val2

		li $v0, 4			## print first label on console
		la $a0, lbl1
		syscall

		move $a0, $t1		## print first number (integer) on console
		li $v0, 1
		syscall

		li $v0, 4			## print second label on console
		la $a0, lbl2
		syscall

		move $a0, $t2		## print second number (integer) on console
		li $v0, 1
		syscall

		li $v0, 4			## print Sum label on console
		la $a0, sum1
		syscall

		add $a0, $t1, $t2	## add the two numbers (integers) together

		li $v0, 1			## print result of addition on console
		syscall

		li $v0, 10			## exit
		syscall