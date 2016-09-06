.data
theStr : .space 6     #declare a space of 6 bytes
thenewStr : .space 6
old : .asciiz "old array: "
new : .asciiz "new array: "
newLine : .asciiz "\n"
.text

main :

lb $t4, newLine

li $v0, 8 					#8=> read string; a0 is buffer; a1 is length
la $a0, theStr 				#load the base address of theStr
li $a1, 6 					#load the length of string(max length of string+1 for '\0')
syscall


add $t2 ,$a0 ,$zero #t2 has the base address

slen_0 : 					# to move the pointer to last char
lb $t3, ($t2)				# load current byte, move to next
addi $t2, $t2, 1
beq $t3, $t4, next 			#if current byte is '\n'
bne $t3,$zero,slen_0 		# if current byte isn't '\0', repeat

next:
add $t1,$a0,$zero 			#load base address
add $t2,$t2,-2

#now t2 has the final address with the last character address

la $a0 ,thenewStr
#now a0 has the intial address of new string

li $t1 ,0
# t0 acts as a counter

li $t4 ,6

store:
lb $t3 , ($t2)
sb $t3 , ($a0)
addi $t2 ,$t2 ,-1
addi $a0 ,$a0 ,1
addi $t0 ,$t0 , 1
beq $t0 ,$t4 , exit
bne $t0 ,$t4 , store

exit:
li $v0, 4
la $a0, old
syscall

not_palin:
li $v0, 4
la $a0, new
syscall

li $v0,10
syscall
