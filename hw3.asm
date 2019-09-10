##############################################################
# Homework #3
# name: Chun_Hung_Li
# sbuid: 110807126
##############################################################
.text
##############################
# FUNCTIONS
##############################

indexOf:
    # Define your code here
    ###########################################
    # DELETE THIS CODE. Only here to allow main program to run without fully implementing the function
    #indexOf_str: .asciiz "abracadabra"
	#indexOf_ch: .asciiz "g"
	#indexOf_startIndex: .word 3
	#la $a0, indexOf_str
    #la $a1, indexOf_ch
    #lbu $a1, 0($a1)
    #lw $a2, indexOf_startIndex
    #li $v0, -200
    move $t0, $0
    startIndexShift:
    	bltz $a2, returnNegativeOne
    	beqz $a2, searchChar
    	addi $a0, $a0, 1	# increment address / go to next character
    	addi $t0, $t0, 1	# index count
    	addi $a2, $a2, -1
    	j startIndexShift
    searchChar:
    	lbu $t1, 0($a0)
    	beq $t1, $zero, returnNegativeOne
    	beq $t1, $a1, returnAscii
    	addi $a0, $a0, 1	# increment address / go to next character
    	addi $t0, $t0, 1	# index count
    	j searchChar
    returnNegativeOne:
    	li $v0, -1 # return value
    	j completeIndexOf
    returnAscii:
    	move $v0, $t0
    completeIndexOf:
    move $t0, $0		
    move $t1, $0
    ##########################################
    jr $ra

replaceAllChar:
    # Define your code here
    ###########################################
    # DELETE THIS CODE. Only here to allow main program to run without fully implementing the function
    #move $v0, $a1
    #li $v1, -200
    #replaceAllChar_str: .asciiz "Stony Brook"
	#replaceAllChar_pattern: .asciiz "oBhy"
	#replaceAllChar_replacement: .ascii "q"
    #la $a0, replaceAllChar_str
    #la $a1, replaceAllChar_pattern
    #la $a2, replaceAllChar_replacement
    #lbu $a2, 0($a2)
    prepRAC:
    	li $v1, -1								# prep for error
    	move $v0, $a0							# prep for no change
    	beqz $a2, completeRAC 					# check for no replacement char 
    	lbu $t1, 0($a1)							# prep pattern char to check
    	beqz $t1, completeRAC					# check for no pattern char
    	li $t3, 0								# corrects address
    	addi $v1, $v1, 1
    loopRAC:
    	lbu $t1, 0($a1)							# load the pattern char
    	beq $t1, $zero, completeRAC				# check if finished
    	innerLoopRAC:
    		lbu $t2, 0($a0)						# load a char of the string
    		beqz $t2, completeInnerLoopRAC
    		bne $t1, $t2, mismatchRAC			# check if the chars are the same
    		sb $a2, 0($a0)						# since chars are the same, replace the char with the replacement char
    		addi $v1, $v1, 1  					# since something was replaced, increment the amount of replaced
    		mismatchRAC:
    			addi $a0, $a0, 1				# go to the next char
    			addi $t3, $t3, 1				# correction
    		j innerLoopRAC
    	completeInnerLoopRAC:
    		sub $a0, $a0, $t3					# reset the string
    		li $t3, 0							# correction back to 0
    		addi $a1, $a1, 1					# increment pattern
    		j loopRAC
    	completeRAC:
    		move $v0, $a0						# copy address of string to $v0
    ##########################################
    jr $ra

countOccurrences:
    # Define your code here
    ###########################################
    # DELETE THIS CODE. Only here to allow main program to run without fully implementing the function
    # li $v0, -200
    # countOccurrences_msg: .asciiz "\n##### Testing countOccurrences #####"
	# countOccurrences_str: .asciiz "Let's Go Seawolves!"
	# countOccurrences_searchChars: .asciiz "qsgo!"
	# la $a0, countOccurrences_str
    # la $a1, countOccurrences_searchChars
    prepCO:
    	lbu $t0, 0($a0)							# load first ascii of string to check if empty
    	lbu $t1, 0($a1)							# load first ascii of character set to check if empty
    	beqz $t0, completeCO					# test if string is empty
    	beqz $t1, completeCO					# test if character set is empty
    	li $t3, 0								# correction counter
    	li $v0, 0
    loopCO:
    	lbu $t1, 0($a1)							# load first ascii in character set
    	beqz $t1, completeCO 					# check if finished
    	innerLoopCO:
    		lbu $t0, 0($a0)						# load a char of the string
    		beqz $t0, completeInnerLoopCO
    		bne $t1, $t0, mismatchCO			# check if the chars are the same
    		addi $v0, $v0, 1					# increment this
    		mismatchCO:
    			addi $a0, $a0, 1
    			addi $t3, $t3, 1
    		j innerLoopCO
    	completeInnerLoopCO:
    		sub $a0, $a0, $t3					# reset the string
    		li $t3, 0							# correction back to 0
    		addi $a1, $a1, 1					# increment pattern
    		j loopCO
    completeCO:
    		
    ##########################################
    jr $ra

replaceAllSubstr:
    # Define your code here
    ###########################################
    # DELETE THIS CODE. Only here to allow main program to run without fully implementing the function
    # replaceAllSubstr_dst: .ascii "hqyTGng72ABHy7@1ncf"
	# replaceAllSubstr_dstLen: .word 19
	# replaceAllSubstr_str: .asciiz "Seawolves!"
	# replaceAllSubstr_findStr: .asciiz "oTse"
	# replaceAllSubstr_replaceStr: .asciiz "XY"
	# la $a0, replaceAllSubstr_dst
    # lw $a1, replaceAllSubstr_dstLen
    # la $a2, replaceAllSubstr_str
    # la $a3, replaceAllSubstr_findStr
    # addi $sp, $sp, -4
    # la $t0, replaceAllSubstr_replaceStr
    # sw $t0, 0($sp)
    # move $v0, $a3
    # li $v1, -200
    preRASS:
    	lw $t9, 0($sp) 						# load replaceAllSubstr_replaceStr from the stack
    	addi $sp, $sp, -4					# decrement the stack
    	sw $ra, 0($sp)						# store the callee
    	addi $sp, $sp, -4					# decrement the stack
    	sw $a0, 0($sp)						# store this function's $a0 into the stack 
    	addi $sp, $sp, -4					# decrement the stack
    	sw $a1, 0($sp)						# store this function's $a1 into the stack
    	move $a0, $a2						# copy the string into $a0
    	move $a1, $a3						# copy the findStr into $a1
    	jal countOccurrences				# countOccurences
    	move $v1, $v0						# move for future use
    	lw $a1, 0($sp)						# restore original $a1
    	addi $sp, $sp, 4					# increment the stack
    	lw $a0, 0($sp)						# restore original $a0
    	addi $sp, $sp, 4					# increment the stack
    	move $t1, $0
    	move $t2, $0
    	move $t3, $0
    	lbu $t1, 0($a2)
    	beqz $t1, errorRASS
    	lbu $t1, 0($a3)
    	beqz $t1 errorRASS
    	countLengthReplaceStr:
    		lbu $t1, 0($t9)					# load ascii of ReplaceStr
    		beqz $t1, preCountLengthString 	# ends when null
    		addi $t2, $t2, 1				# increment lengthCounter
    		addi $t9, $t9, 1				# increment address
    		j countLengthReplaceStr
    	preCountLengthString:
    		sub $t9, $t9, $t2				# original address
    	countLengthString:
    		lbu $t1, 0($a2)					# load ascii of string
    		beqz $t1, preDetermineValidity	# ends when null
    		addi $t3, $t3, 1				# increment lengthCounter of string
    		addi $a2, $a2, 1				# increment address
    		j countLengthString 
    	preDetermineValidity:
    		sub $a2, $a2, $t3				# original address
    	determineValidity:
    		addi $t2, $t2, -1				# prepare calculation for string with replacements
    		mult $t2, $v0					# multiply number of additional asciis in replacement with number of occurences
    		mflo $t4						# store product in $t4
    		add $t5, $t3, $t4				# add additional ascii and original string length
    		addi $t5, $t5, 1				# account for null terminating character
    		move $t6, $t5
    		bgt $t5, $a1, errorRASS			# if the final string length will be greater than the dstLen, go to error
    		j loopRASS
    	errorRASS:
    		li $v1, -1						# load -1 into $v1
    		move $v0, $a0					# move original DST into $v0
    		j completeErrorRASS
    loopRASS:
    	move $t4, $0
    	move $t5, $0
    	lbu $t1, 0($a2)						# load ascii of string
    	beqz $t1, completeRASS				# once you reach the null terminator, finish loop
    	innerLoopRASS:
    		lbu $t2, 0($a3)					# load ascii of findStr
    		beqz $t2, completeInnerLoopRASS	# when you reach the end of the findstr, finish inner loop
    		bne $t1, $t2, misMatchRASS		# when ascii don't match, skip to misMatchRASS
    		innerInnerLoopRASS:
    			lbu $t3, 0($t9)				# load char of replaceStr
    			beqz $t3, completeInnerInnerLoopRASS # all chars replaced, fix address
    			sb $t3, 0($a0)				# store the replaceStr into dst
    			addi $t9, $t9, 1			# increment the replaceStr
    			addi $a0, $a0, 1			# increment the dst
    			addi $t5, $t5, 1			# increment correction 
    			j innerInnerLoopRASS
    		completeInnerInnerLoopRASS:
    			sub $t9, $t9, $t5			# correct replaceStr
    			move $t5, $0				# reset counter
    			addi $a0, $a0, -1
    			j completeInnerLoopRASS
    		misMatchRASS:
    			sb $t1, 0($a0)				# store the original string ascii into dst
    			addi $a3, $a3, 1			# increment address of findStr
    			addi $t4, $t4, 1			# increment correction
    		j innerLoopRASS
    	completeInnerLoopRASS:
    		sub $a3, $a3, $t4				# correct findStr ascii
    		addi $a0, $a0, 1			# increment the dst
    		move $t4, $0					# reset counter
    		addi $a2, $a2, 1				# increment next String
    		j loopRASS
    completeRASS:
    	sb $0, 0($a0)
    	addi $t6, $t6, -1
    	sub $a0, $a0, $t6
    	move $v0, $a0
    completeErrorRASS:
    lw $ra, 0($sp)						# restore the callee
    addi $sp, $sp, 4					# increment the stack
    ##########################################
    jr $ra

split:
    # Define your code here
    ###########################################
    # DELETE THIS CODE. Only here to allow main program to run without fully implementing the function
    # li $v0, -200
    # li $v1, -200
    # .align 2
	# split_dst: .space 40
	# split_dstLen: .word 10
	# split_str: .asciiz ""
	# split_delimiter: .ascii
	# la $a0, split_dst
    # lw $a1, split_dstLen
    # la $a2, split_str
    # la $a3, split_delimiter
    # lbu $a3, 0($a3)
    lbu $t0, 0($a2)								# load first bit of the string
    beqz $t0, no_string							# if string is empty, go to no_string
    addi $sp, $sp, -4							# decrement stack
    sw $ra, 0($sp)								# store callee
    addi $sp, $sp, -4							# decrement stack
    sw $a0, 0($sp)								# store dst
    addi $sp, $sp, -4							# decrement stack
    sw $a1, 0($sp)								# store dstLen
    addi $sp, $sp, -4							# decrement stack
    sw $a2, 0($sp)								# store str
    move $a0, $a2								# move string into $a0 
    move $a1, $a3								# move character into $a1
    move $a2, $0								# set $a2 to zero
    jal indexOf									# check if the string has delimiter within it
    lw $a2, 0($sp)								# load str back into $a2
    addi $sp, $sp, 4							# increment stack
    lw $a1, 0($sp)								# load dstLen back into $a1
    addi $sp, $sp, 4							# increment stack
    lw $a0, 0($sp)								# load dst back into $a0
    addi $sp, $sp, 4							# increment stack
    bltz $v0, one_token							# if delimiter not found in string, then go to one_token
    bnez $v0, loopSPLIT							# if the delimiter index is zero, skip
    sb $t0, 0($a2) 								# set delimiter to null
    sw $a2, 0($a0)								# store the address into first index of dst array
    addi $a0, $a0, 4							# increment array
    addi $t4, $t4, 4							# correction counter
    addi $a2, $a2, 1							# increment string
    addi $t1, $t1, 1							# increment count
    loopSPLIT:
    	beq $t1, $a1, almostCompleteSPLIT2				# if word count has been maxed
    	lbu $t2, 0($a2)							# load ascii of $a2
    	beqz $t2, delimiterEnd					# if reach null in this stage, there's was a delimiter at the end
    	bne $t2, $a3, mismatchSPLIT				# if the ascii value matches the delimiter twice in a row
    	move $t0, $0
    	sb $t0, 0($a2)							
    	sw $a2, 0($a0)							# store the address into first index of dst array
    	addi $a0, $a0, 4						# increment array
    	addi $t4, $t4, 4						# correction counter
    	addi $a2, $a2, 1						# increment string address
    	addi $t1, $t1, 1						# increment count
    	j loopSPLIT
    	mismatchSPLIT:
    	sw $a2, 0($a0)							# store address into DST
    	addi $t4, $t4, 4						# correction counter
    	addi $a0, $a0, 4						# increment array
    	addi $t1, $t1, 1						# increment word counter
    	innerLoopSPLIT:
    		lbu $t2, 0($a2)						# load ascii of $a2
    		beqz $t2, almostCompleteSPLIT  		# if null is reached, completeSPLIT
    		bne $t2, $a3, mismatchSPLIT2		# if the ascii value matches the delimiter
    		move $t0, $0
    		sb $t0, 0($a2)
    		addi $a2, $a2, 1					# increment string address
    		j loopSPLIT
    		mismatchSPLIT2:
    		addi $a2, $a2, 1					# increment string address
    		j innerLoopSPLIT
    delimiterEnd:
    	move $t0, $0
    	sb $t0, 0($a2)
    	sw $a2, 0($a0)
    	addi $t1, $t1, 1
    	addi $t4, $t4, 4						# correction counter
    	j almostCompleteSPLIT2
    no_string:
    	li $v0, 0
    	li $v1, -1
    	j completeSPLIT
    one_token:
    	sw $a2, 0($a0)							# store the string into the array dst
    	li $v0, 1								# one address
    	li $v1, 0								# valid
    	j completeSPLIT
    almostCompleteSPLIT:
    	li $t5, 4
    	mult $t5, $t1
    	mflo $t5
    	sub $a0, $a0, $t5
    	move $v0, $t1
    	li $v1, 0
    	j completeSPLIT
    almostCompleteSPLIT2:
    	li $t5, 4
    	mult $t5, $t1
    	mflo $t5
    	sub $a0, $a0, $t5
    	move $v0, $t1
    	lbu $t2, 0($a2)							# load ascii of $a2
    	bne $t2, $0, leftovers
    	li $v1, 0
    	j completeSPLIT
    	leftovers:
    	li $v1, -1
    completeSPLIT:
    move $t0, $0
    lw $ra, 0($sp)						# restore the callee
    addi $sp, $sp, 4					# increment the stack
    ##########################################
    jr $ra
