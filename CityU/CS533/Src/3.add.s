.data
msg:    .asciiz "\nHello World! My name is Dr. Block\n" 
lbl1:  .asciiz "\nEnter first integer: "
lbl2:  .asciiz "\nEnter second integer:"
lbl3:  .asciiz "\nThe total is: "


#Assemmbly Code
.text
.globl main

main:
		# print Hello World to console
		li $v0, 4       # syscall 4 (print_str)
        la $a0, msg     
        syscall         
        
        # print the first label to the console
		li $v0, 4       # syscall 4 (print_str)
		la $a0, lbl1
		syscall

        # prompt for the first integer
		li $v0, 5       # syscall 5 (read_int)
		syscall
        move $t1, $v0
		
		# print the second label to the console
		li $v0, 4       # syscall 4 (print_str)
		la $a0, lbl2
		syscall
		
		# prompt for the second integer
		li $v0, 5       # syscall 5 (read_int)
		syscall
        move $t2, $v0

		# print the total label to the console
		li $v0, 4       # syscall 4 (print_str)
        la $a0, lbl3
		syscall
		
		# add the two intgers
		add $a0, $t1, $t2
		
		# print the sum to the console window
		li $v0, 1       # syscall 1 (print_int)
		syscall
		
		# finished
        li $v0, 10      # syscall 10 (exit)
		syscall
