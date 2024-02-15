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
    li $t0, 0       # Counter for substring index
    li $t1, 0       # Counter for sum

process_substring:
    add $t2, $a0, $t0 # load current substring address
    lb $t3, 0($t2) # load current character
    beq $t3, $zero, end_process_substring # checks if current character is null terminator
    beq $t3, delimiter, calculate_sum # checks if current character is delimiter

    # increment substring index
    addi $t0, $t0, 1
    j process_substring