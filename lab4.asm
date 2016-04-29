#
#  base64decode.s (incomplete)
#
#  by Deborah Pickett 2003-02-27
#
#  This MIPS program reads lines of Base 64-encoded text from standard
#  input, and outputs the decoded bytes to standard output.
#

# INSERT YOUR CODE AT THE POINT INDICATED BELOW.

#
# Data segment
#
        .data
        # Space to read a line into.
inbuffer: .space 80
        # The Base 64 alphabet, in order.
sequence: .asciiz "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

#
# Text segment
#
        .text
        # Program entry.
main:
        # The first byte we're expecting is byte 0 of a group of 4.
        la $t9, byte0

        # Read a string from standard input.
loop:   li $v0, 8
        la $a0, inbuffer
        li $a1, 80
        syscall

        # Is this an empty line?  Since SPIM can't detect when end of
        # file has been reached, we need to use another way to indicate
        # the end of the Base 64 data.  We'll use a completely
        # blank line for this.
        lb $t0, inbuffer
        # First character newline means there was no text on this line,
        # so end the program.
        beq $t0, 10, alldone

        # Walk along the string.  Start at the beginning.
        la $t8, inbuffer

        # Go back to where we left off last time (byte 0, 1, 2 or 3).
        jr $t9


        # Get four characters at a time.
byte0:  lbu $s0, 0($t8)
        add $t8, $t8, 1
        beq $s0, 10, linedone
        
        # Now up to byte 1.
        la $t9, byte1
byte1:  lbu $s1, 0($t8)
        add $t8, $t8, 1
        beq $s1, 10, linedone

        # Now up to byte 2.
        la $t9, byte2
byte2:  lbu $s2, 0($t8)
        add $t8, $t8, 1
        beq $s2, 10, linedone

        # Now up to byte 3.
        la $t9, byte3
byte3:  lbu $s3, 0($t8)
        add $t8, $t8, 1
        beq $s3, 10, linedone

        # Now all bytes in this block are read.
        # Four Base64 characters are now in $s0, $s1, $s2, $s3.
bytesdone:
        #
        # DO NOT DELETE THIS LINE.

        ######
        #Byte 0
        add $t0,$s0,$0
	li $t1,110000 
	and $t0,$s1,$t1
	srl $t0,$t0,4
	sll $s0,$s0,2
	add $s4,$s1,$t0 #output
	#Byte 1
	add $t0,$s1,$0
	add $t1,$s2,$0
	
	li $t2 001111
	and $t0,$t0,$t2
	
	srl $t1,$t1,2
	
	sll $t0,$t0,4
	
	add $s5,$t0,$t1 #output
	#Byte 2
	add $t0,$s2,$0
	add $t1,$s3,$0
	
	li $t2,000011
	and $t0,$t0,$t2
	sll $t0,$t0,6
	
	add $s6,$t0,$s3
	
	
	
	
	
        ######

        # DO NOT DELETE THIS LINE.
        #
endgroup:
        # Go back to do next bunch of four bytes.  We're now expecting
        # byte 0 of 4.
        la $t9, byte0
        j byte0

linedone:
        # Line is finished; go get another one.
        j loop

alldone:
        # Exit.
        li $v0, 10
        syscall