.data
msg:    .asciiz "\nHello World! My name is Dr. Block\n" 
lbl1:  .asciiz "\nEnter integer 1 (base): "
lbl2:  .asciiz "\nEnter integer 2 (exponent):"
lbl3:  .asciiz "\nThe base^exponent is: "


#Assemmbly Code
.text
.globl main

main:
		# print Hello World to console
		li $v0, 4				# syscall 4 (print_str)
        la $a0, msg     
        syscall         
        
        # print the first label to the console
		li $v0, 4				# syscall 4 (print_str)
		la $a0, lbl1
		syscall

        # prompt for the first integer
		li $v0, 5				# syscall 5 (read_int)
		syscall
        move $t1, $v0
		
		# print the second label to the console
		li $v0, 4				# syscall 4 (print_str)
		la $a0, lbl2
		syscall
		
		# prompt for the second integer
		li $v0, 5				# syscall 5 (read_int)
		syscall
        move $t2, $v0

		# print the total label to the console
		li $v0, 4				# syscall 4 (print_str)
        la $a0, lbl3
		syscall
		
		li $t4, 1				#initialize result with 1

		# loop $t2 times, multiplying the result by the base each time
loop:	
		mul $t4, $t4, $t1
		addi $t2, $t2, -1		# decrement counter
		bne $t2, $zero, loop	# check if done


		# print the result to the console window
		move $a0, $t4
		li $v0, 1				# syscall 1 (print_int)
		syscall
		
		# finished
        li $v0, 10      # syscall 10 (exit)
		syscall
