    .data
input_string:   .space 1001   # reserves space for input string (up to 1000 characters + null terminator)
delimiter:      .asciiz "/"   # defines delimiter as "/"
sum_label:      .asciiz "Sum: "  # outputs label for sum

    .text
    .globl main

main:
    # prompts the user for input string
    li $v0, 4
    la $a0, input_prompt
    syscall

    # reads input string from user
    li $v0, 8
    la $a0, input_string
    li $a1, 1000   # max length to read
    syscall

    # calls on process_whole_string subroutine
    la $a0, input_string
    jal process_whole_string

    # exits the program
    li $v0, 10
    syscall

# subroutine which processes the input string
process_whole_string:
    # initialize variables
    li $t0, 0       # counter for substring index
    li $t1, 0       # counter for sum

process_substring:
    add $t2, $a0, $t0	# load current substring address
    lb $t3, 0($t2)	# load current character
    beq $t3, $zero, end_process_substring	# checks if current character is null terminator
    beq $t3, delimiter, calculate_sum		# checks if current character is delimiter

    # increment substring index
    addi $t0, $t0, 1
    j process_substring

calculate_sum:
    # process the substring, calculate sum, and initialize variables
    li $t4, 0       # accumulator for the current number
    li $t5, 10      # multiplier for decimal places, starting at 1 (units)
    li $t6, 1       # flag to indicate positive number (1) or negative number (-1)
    li $t7, 0       # flag to indicate if a number is being formed (0 for no, 1 for yes)

calculate_sum_loop:
    add $t2, $a0, $t0	# loads address of current character
    lb $t3, 0($t2)	# loads current character
    beq $t3, $zero, process_current_number	# checks if current character is null terminator

    # checks if the current character is a minus sign
    li $t8, '-'
    beq $t3, $t8, set_negative_flag

    # checks if the current character is a digit
    li $t8, '0'
    blt $t3, $t8, next_iteration
    li $t8, '9'
    bgt $t3, $t8, next_iteration

    # converts ASCII to integer and accumulates the number
    sub $t3, $t3, '0'   # converts ASCII to integer
    mul $t4, $t4, $t5   # multiplies existing number by 10
    add $t4, $t4, $t3   # adds current digit to the number
    li $t7, 1           # sets flag indicating that a number is being formed

next_iteration:
    # increments substring index
    addi $t0, $t0, 1
    j calculate_sum_loop

set_negative_flag:
    # sets negative flag
    li $t6, -1
    j next_iteration

process_current_number:
    mul $t4, $t4, $t6	# multiply the number by the sign flag (1 for positive, -1 for negative)
    add $t1, $t1, $t4	# accumulates the sum



