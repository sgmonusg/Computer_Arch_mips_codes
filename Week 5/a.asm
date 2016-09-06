.data
theStr : .space 6     #declare a space of 6 bytes
isPal : .asciiz "Its is a Palindrome"
notPal : .asciiz "Not a Palindrome"
newLine : .asciiz "\n"
.text

main :

lb $t4, newLine

li $v0, 8 					#8=> read string; a0 is buffer; a1 is length
la $a0, theStr 				#load the base address of theStr
li $a1, 6 					#load the length of string(max length of string+1 for '\0')
syscall

add $t2,$a0,$zero 			#load base address in t2; find input string length

slen_0 : 					# to move the pointer to last char
lb $t3, ($t2)				# load current byte, move to next
addi $t2, $t2, 1
beq $t3, $t4, next 			#if current byte is '\n'
bne $t3,$zero,slen_0 		# if current byte isn't '\0', repeat

next:
add $t1,$a0,$zero 			#load base address
add $t2,$t2,-2				

test_loop:
bge $t1, $t2,is_palin		# if lower pointer >= upper pointer, yes
lb $t3, ($t1)				# grab the char at lower ptr
lb $t4, ($t2)				# grab the char at upper ptr
bne $t3, $t4, not_palin 	# if different, it's not
addi $t1, $t1, 1			# advance lower ptr
addi $t2,$t2,-1
j test_loop					# repeat the loop

is_palin:
li $v0, 4
la $a0, isPal
syscall
j exit


not_palin:
li $v0, 4
la $a0, notPal
syscall

exit:
li $v0,10
syscall
