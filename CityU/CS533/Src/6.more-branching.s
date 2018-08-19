.data
msg:    .asciiz "\nHello World! My name is Dr. Block\n" 
lbl1:	.asciiz "\nEnter the first integer: "
lbl2:	.asciiz "\nEnter the operator (+, -, *, /): "
lbl3:	.asciiz "\nEnter the second integer: "
lbl4:	.asciiz "\nThe result is: "
err1:	.asciiz "\nInvalid operator"
rep:	.asciiz "\nWould you like to repeat (y/n)? "
fin:	.asciiz "\nFinished"

#Assemmbly Code
.text
.globl main

main:
		# print Hello World to console
		li $v0, 4       # syscall 4 (print_str)
        la $a0, msg     
        syscall    

rpt:
		jal get_int1	# get the first integer
		jal get_oper	# get the operator
		jal get_int2	# get the second integer

		# branch on the selected operator
		beq $t2, 42, mul_ints	# * multiply
		beq $t2, 43, add_ints	# + add
		beq $t2, 45, sub_ints	# - subtract
		beq $t2, 47, div_ints	# / divide

got_calc:
		jal dsp_res		# display the result

		jal get_rep		# does the user wish to continue?

		beq $t2, 89, rpt	# Y character
		beq $t2, 121, rpt	# y character

		# print Finished to console
		li $v0, 4       # syscall 4 (print_str)
        la $a0, fin     
        syscall    

		# finished
        li $v0, 10      # syscall 10 (exit)
		syscall

get_int1:		
        # print the first label to the console
		li $v0, 4       # syscall 4 (print_str)
		la $a0, lbl1
		syscall

        # prompt for the first integer
		li $v0, 5       # syscall 5 (read_int)
		syscall
        move $t1, $v0
		jr $ra

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
		beq $t2, 42, got_oper	# * multiply
		beq $t2, 43, got_oper	# + add
		beq $t2, 45, got_oper	# - subtract
		beq $t2, 47, got_oper	# / divide

		# print the error label to the console
		li $v0, 4       # syscall 4 (print_str)
		la $a0, err1
		syscall

		j get_oper

got_oper:
		jr $ra		

add_ints:
		add $t4, $t1, $t3
		j got_calc

mul_ints:
		mul $t4, $t1, $t3
		j got_calc

div_ints:
		div $t4, $t1, $t3
		j got_calc

sub_ints:
		sub $t4, $t1, $t3
		j got_calc

get_rep:
		# print the repeat  label to the console
		li $v0, 4       # syscall 4 (print_str)
        la $a0, rep
		syscall

		# prompt for the character
		li $v0, 12       # syscall 12 (read_char)
		syscall
        move $t2, $v0
		jr $ra

dsp_res:
		# print the results label to the console
		li $v0, 4       # syscall 4 (print_str)
        la $a0, lbl4
		syscall

		# print the results to the console window
		move $a0, $t4
		li $v0, 1       # syscall 1 (print_int)
		syscall
		jr $ra
