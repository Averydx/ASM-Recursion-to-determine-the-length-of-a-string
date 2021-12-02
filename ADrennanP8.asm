#Programming Assignment 8- Recursive function to determine the length of a string 

.data 
string: .asciiz "BLAH BLAH BLAH BLAH" #The string for which we will compute the length 

str_length: .asciiz "The length of the string is: "

.text 
.globl main 

main: 
la $a0,string #loads the address of the string into $a0
jal StrLen #jumps to execution of StrLen and stores the PC+4 in $ra
move $s0,$v0 #moves the length count out of $v0 to preserve it 

#The following 3 lines print str_length to the console
la $a0,str_length
addi $v0,$0,4
syscall

#The following 3 lines print the length of the string to the console
add $a0,$s0,$0
addi $v0,$0,1
syscall

#The following 2 lines exit the program
addi $v0,$0,10
syscall

StrLen: 
lb $t0,($a0) #loads the byte at the current address into $t0
bne $t0,$0,Continue #if $t0 is not 0, indicating the null character, then go to Continue
jr $ra

Continue: 
addi $sp,$sp,-4 #allocates 4 bytes on the stack for the return address
sw $ra,0($sp) #pushes the value of $ra onto the stack 
addi $a0,$a0,1 #increments $a0 by 4 to point to point to the next byte in the word
jal StrLen #recursively jumps back to the label 
b Finish

Finish: 
lw $ra,0($sp) #loads the return address from the stack into $ra
addi $v0,$v0,1 #increments the string length counter
addi $sp,$sp,4 #moves the stack pointer back by 4
jr $ra