    .data
input_string:   .space 1001   # reserves space for input string (up to 1000 characters + null terminator)
delimiter:      .asciiz "/"   # defines delimiter as "/"
sum_label:      .asciiz "Sum: "  # outputs label for sum