    .data
input_string:   .space 1001   # reserves space for input string (up to 1000 characters + null terminator)
delimiter:      .asciiz "/"   # defines delimiter as "/"
sum_label:      .asciiz "Sum: "  # outputs label for sum

    .text
    .globl main

main:
    # Prompt user for input string
    li $v0, 4
    la $a0, input_prompt
    syscall
