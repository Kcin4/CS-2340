# Nicholas Phan
# 9/3/2021
# HW 1 - MIPS Programming Basics

.data
a:		.word 3		# creating 3 memory locations to hold input values a, b, and c
b:		.word 4
c:		.word 5
ans1:		.word 7		# creating 3 memory locations to hold output values
ans2:		.word 8
ans3:		.word 9
namePrompt:	.asciiz "What is your name? "					# creating memory location for the name of the user prompt
inName:		.asciiz "blank"							# creating memory location to hold users name
numPrompt:	.asciiz "Please enter an integer between 1-100: "		# creating memory location to prompt user for integers
results:	.asciiz "Your answers are: "					# creating memory location for results message
space:		.asciiz " "							# creating memory location for space between results message integers

.text
main:
		# prompt user for name
		li	$v0, 4
		la	$a0, namePrompt
		syscall
		
		# save user's name in memory
		li	$v0, 8
		li	$a1, 20		# allows maximum number of characters to read
		la	$a0, inName
		syscall
		
		# prompt user for first number
		li	$v0, 4
		la	$a0, numPrompt
		syscall
		
		# user inputs first number and it is stored in 'a'
		li	$v0, 5
		syscall
		sw	$v0, a
		
		# prompt user for second number
		li	$v0, 4
		la	$a0, numPrompt
		syscall
		
		# user inputs second number and it is stored in 'b'
		li	$v0, 5
		syscall
		sw	$v0, b
		
		# prompt user for third number
		li	$v0, 4
		la	$a0, numPrompt
		syscall
		
		# user inputs third number and it is stored in 'c'
		li	$v0, 5
		syscall
		sw	$v0, c
		
		# first calculation (2a - c + 4)
		lw	$t1, a		# loading a and c into temporary registers
		lw	$t2, c
		add	$t0, $t1, $t1	# t0 = a + a = 2a
		sub	$t0, $t0, $t2	# t0 = t0 - c = 2a - c
		add	$t0, $t0, 4	# t0 = t0 - 4 = (2a - c) + 4
		sw	$t0, ans1	# stores $t0 into ans1
		
		# second calculation (b - c + (a - 2)
		lw	$t1, a		# loading input values into temp registers
		lw	$t2, b	
		lw	$t3, c
		sub	$t6, $t1, 2	# t6 = a - 2
		sub	$t0, $t2, $t3	# t0 = b - c
		add	$t0, $t0, $t6	# t0 = (b-c) + (a-2)
		sw	$t0, ans2	# stores t0 into ans2
		
		# third calculation ((a + 3) - (b - 1) + (c + 3))
		lw	$t1, a		# loading input values into temp registers
		lw	$t2, b
		lw	$t3, c
		add	$t4, $t1, 3	# t4 = a + 3
		sub	$t5, $t2, 1	# t5 = b - 1
		add	$t6, $t3, 3	# t6 = c + 3
		sub	$t0, $t4, $t5	# t0 = (a+3) - (b-1)
		add	$t0, $t0, $t6	# t0 = ((a+3) - (b-1)) + (c+3)
		sw	$t0, ans3	# stores t0 into ans3
		
		# prints name given
		li	$v0, 4
		la	$a0, inName
		syscall
		
		# prints results
		li	$v0, 4
		la	$a0, results	# prints results message
		syscall
		li	$v0, 1		
		lw	$a0, ans1	# prints answer 1
		syscall
		li	$v0, 4
		la	$a0, space	# prints a comma and a space
		syscall
		li	$v0, 1		
		lw	$a0, ans2	# prints answer 2
		syscall
		li	$v0, 4
		la	$a0, space
		syscall
		li	$v0, 1
		lw	$a0, ans3
		syscall
		
exit:		# exits program
		li $v0, 10
		syscall
		
		
		
		
# test 1 values a=35, b=22, c=57
# test 1 expected = 17, -2, 77

# test 2 values a=14, b=2, c=99
# test 2 expected = -67, -85, 118