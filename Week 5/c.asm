.data
my_arr : .word 1 3 2 4
newLine : .asciiz "\n"
.text

main :
lb $t4, newLine
la $t1 , my_arr

exit:




