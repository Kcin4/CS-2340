# Nicholas Phan
# 9/18/2021
# HW 2 - MIPS Control Structures

.data
	wordCount:	.word	1
	charCount:	.word	-1
	charOutput:	.asciiz "Number of characters: "
	wordOutput:	.asciiz "Number of words: "
	exitTitle:	.asciiz "Goodbye! "
	exitMessage:	.asciiz "Thanks for using my program!"
	someSpace:	.space	25
	newLine:	.asciiz "\n"
	inputPrompt:	.asciiz "Enter some text:"
	inputString:	.asciiz " "
		.align 2

.text
main:		sw	$0, inputString		# resets the inputString to 0 at the start of every loop
		li	$v0, 54			# syscall for InputDialogString
		la	$a0, inputPrompt	# Prompt for user input
		la	$a1, inputString	# Address where the input string is saved = $a1
		li 	$a2, 50			# Maximum number of characters to read
		syscall
		
		li	$v0, 4			# ouputs the string entered
		la	$a0, inputString
		syscall
		
		la	$t9, inputString	# loads the address of the string to $t9
		li	$v0, -1			# character counter = $v0
		li	$v1, 1			# word counter = $v1

		lb	$t6, 0($t9)		# loads the first byte of the string address to $t6
		beq	$t0, $t6, exit		# if $t6 is a "0" or blank, go to the exit function
compare:	
		li	$s1, 1000		# this is just a demonstration of how I would use push, although I didn't find any use for it in this program
		addi	$sp, $sp, -4		# storing $s1 on the stack
		sw	$s0, ($sp)
		
		sw	$v0, charCount		# stores the "return value $v0" to charCount
		sw	$v1, wordCount		# stores the "return value $v1" to wordCount
		la	$s1, ($t9)		# load the address of the inputString to $s1
		lb	$t5, ($s1)		# $t5 becomes the character to be compared
		beq	$t5, ' ', wordCounter	# if $t5 is a space, go to wordCounter function
		bne	$t5, ' ', charCounter	# if $t5 is not a space, go to charCounter function
		
		lw	$s0, ($sp)		# a demonstration of using pop
		addi	$sp, $sp, 4		# taking $s1 off the stack
		
charCounter:
		beq	$t5, $zero, output	# if you have reached the end of the string, go to output function
		addi	$v0, $v0, 1		# increments the character counter
		addi	$t9, $t9, 1		# increments the string index
		j	compare			# jump back to compare
		
wordCounter:
   		addi	$v1, $v1, 1		# increments the "word" counter
   		addi	$v0, $v0, 1		# also increments the character counter because a space is a character
		addi	$t9, $t9, 1		# increments the string index
		j	compare			# jump back to compare

output:
		li	$v0, 4			# ouputs the Number of Words: message
		la	$a0, wordOutput
		syscall
		
		lw	$t8, wordCount
		li	$v0, 1			# outputs the number of words
		la	$a0, ($t8)
		syscall
		
		li	$v0, 4			# prints a new line
		la	$a0, newLine
		syscall
		
		li	$v0, 4			# outputs the Number of Characters: message
		la	$a0, charOutput
		syscall
		
		lw	$t7, charCount
		li	$v0, 1			# outputs the number of characters
		la	$a0, ($t7)
		syscall
		
		li	$v0, 4			# prints a new line
		la	$a0, newLine
		syscall
		
		j 	main			# jump back to main
		
exit:		# exits program
		li	$v0, 59
		la	$a0, exitTitle
		la	$a1, exitMessage
		syscall
		
		li 	$v0, 10
		syscall
		
