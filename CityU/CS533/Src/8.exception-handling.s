.data
msg:    .asciiz "\nHello World! My name is Dr. Block\n" 
lbl1:	.asciiz "\nEnter the first integer: "
lbl2:	.asciiz "\nEnter the operator (+, -, *, /, ^, #): "
lbl3:	.asciiz "\nEnter the second integer: "
lbl4:	.asciiz "\nThe result is: "
err1:	.asciiz "\nInvalid operator"
rep:	.asciiz "\nWould you like to repeat (y/n)? "
fin:	.asciiz "\nFinished"


# start of program
.text
.globl main

main:

		# print Hello World to console
		li $v0, 4       # syscall 4 (print_str)
        la $a0, msg     
        syscall    

rpt:
		jal get_int1	# get the first integer - $t1
		jal get_oper	# get the operator - $t2
		jal get_int2	# get the second integer - $t3

		# branch on the selected operator
		beq $t2, 42, mul_ints	# * multiply
		beq $t2, 43, add_ints	# + add
		beq $t2, 45, sub_ints	# - subtract
		beq $t2, 47, div_ints	# / divide
		beq $t2, 94, exp_ints	# ^ exponent
		beq $t2, 35, throw_ex	# hash symbol
got_calc:
		jal dsp_res		# display the result

get_next:
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
		beq $t2, 94, got_oper	# ^ exponent
		beq $t2, 35, got_oper	# ^ exponent

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

		mtc1 $t1, $f1		# move the 1st integer into the 1st floating point register
		mtc1 $t3, $f3		# move the 2nd integer into the 2nd floating point register

		cvt.s.w $f1, $f1			# convert the 1st integer to a float
		cvt.s.w $f3, $f3			# convert the 2nd integer to a float

		div.s $f12, $f1, $f3		# divide the 1st float by the 2nd float
		j got_calc

sub_ints:
		sub $t4, $t1, $t3
		j got_calc

exp_ints:
		li $t4, 1					#initialize result with 1	
exp_loop:		
		mul $t4, $t4, $t1
		addi $t3, $t3, -1			# decrement counter $t3
		bne $t3, $zero, exp_loop	# check if done
		j got_calc

throw_ex:
		teqi $t0, 0     			# immediately trap because $t0 contains 0
		j get_next

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

		beq $t2, 47, dsp_flt	# / divide	

		# print the integer results to the console window
		li $v0, 1       # syscall 1 (print_int)
		move $a0, $t4
		j dsp_next

dsp_flt:
		li $v0, 2 # float

dsp_next:
		syscall
		jr $ra
 
 .ktext 0x80000180
   		move $k0, $v0   		# Save $v0 value
   		move $k1, $a0   		# Save $a0 value

   		#print the exception label
   		la   $a0, exc  		# address of string to print
   		li   $v0, 4    		# Print String service
   		syscall

		move $v0, $k0   		# Restore $v0
		move $a0, $k1   		# Restore $a0
		mfc0 $k0, $14   		# Coprocessor 0 register $14 has address of trapping instruction
		addi $k0, $k0, 4 	# Add 4 to point to next instruction
		mtc0 $k0, $14   		# Store new address back into $14
		eret           		# Error return; set PC to value in $14
.kdata	
exc:   
   .asciiz "\nAn exception occurred in the program"
