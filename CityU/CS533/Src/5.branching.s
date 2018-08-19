.data
msg:    .asciiz "\nHello World! My name is Dr. Block\n" 
lbl1:	.asciiz "\nEnter the first integer: "
lbl2:	.asciiz "\nEnter the operator (+, -, *, /): "
lbl3:	.asciiz "\nEnter the second integer: "
lbl4:	.asciiz "\nThe result is: "
err1:	.asciiz "\nInvalid operator"
cr:		.asciiz "\n"


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

get_oper:

		# print the second label to the console
		li $v0, 4       # syscall 4 (print_str)
		la $a0, lbl2
		syscall
		
		# prompt for the character
		li $v0, 12       # syscall 12 (read_char)
		syscall
        move $t2, $v0

		# branch on the selected operator
		beq $t2, 42, mul_ints	# * multiply
		beq $t2, 43, add_ints	# + add
		beq $t2, 45, sub_ints	# - subtract
		beq $t2, 47, div_ints	# / divide

		# print the error label to the console
		li $v0, 4       # syscall 4 (print_str)
		la $a0, err1
		syscall

		j get_oper

get_int2:
		# print the third label to the console
		li $v0, 4       # syscall 4 (print_str)
		la $a0, lbl3
		syscall

		# prompt for the second integer
		li $v0, 5       # syscall 5 (read_int)
		syscall
        move $t3, $v0
		jr $ra

add_ints:
		jal get_int2
		add $t4, $t1, $t3
		j dsp_res

mul_ints:
		jal get_int2
		mul $t4, $t1, $t3
		j dsp_res

div_ints:
		jal get_int2
		div $t4, $t1, $t3
		j dsp_res

sub_ints:
		jal get_int2
		sub $t4, $t1, $t3
		j dsp_res

dsp_res:
		# print the results label to the console
		li $v0, 4       # syscall 4 (print_str)
        la $a0, lbl4
		syscall

		# print the results to the console window
		move $a0, $t4
		li $v0, 1       # syscall 1 (print_int)
		syscall

		# print the carriage return label to the console
		li $v0, 4       # syscall 4 (print_str)
        la $a0, cr
		syscall

		# finished
        li $v0, 10      # syscall 10 (exit)
		syscall
