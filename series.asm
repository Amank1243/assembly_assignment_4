; Author Information:
; Name: Aman Khajuria
; CWID: 812144988
; Section(s): CPSC 240-#8, CPSC 240-#7
; Email: akhajuria@csu.fullerton.edu

%include "macro.inc"

extern printf
extern fgets
extern stdin
extern strlen
extern atoi

extern fill_random_array
extern show_array
extern normalize_array
extern selection_sort


global executive

max_size_of_array equ 100


; Messages displayed by the manager. This is data already declared
segment .data

    global random_number_format
    random_number_format db "IEEE754      Scientific Decimal", 10, 0

    name_input db 10, "Please enter your name:", 10, 0
    title_input db "Please enter your title (Mr,Ms,Sargent,Chief,Project Leader,etc):", 10, 0
    greetings_output db "Nice to meet you %s %s", 10, 0

    program_message db 10, "This program will generate 64-bit IEEE float numbers.", 10, 0
    num_in_array_message db "How many numbers do you want.  Today's limit is 100 per customer. ", 0
    try_again_input_message db "Try again. Make sure the number entered is between or equal to 1 or 100", 10, 0
    display_array_message db 10, "Your numbers have been stored in an array.  Here is that array.", 10, 0
    goodbye_message db 10, "Good bye %s.  You are welcome any time.", 10, 0

    normalize_array_message db 10, "The array will now be normalized to the range 1.0 to 2.0  Here is the normalized array", 10, 0
    sort_array_message db 10, "The array will now be sorted via a C++ function", 10, 0
    string_format db "%s", 0




; Declaring variables for data to be stored in for later
segment .bss

    name resb 128 ; Space for 128 characters
    title resb 128 ; Space for 128 characters

    maximum_number_of_characters_for_input resb 128
    amount_of_random_nums resq 1
    
    array resq 100 ; space for 100 elements to be stored in the array
    segment .text

executive:

    create_activation_record


    ; Print the name input on the screen
    mov rax, 0
    mov rdi, string_format
    mov rsi, name_input
    call printf

    ; Get the name
    mov rdi, name
    mov rsi, maximum_number_of_characters_for_input
    mov rdx, [stdin]
    call fgets

    ; get the length of name using the strlen C function. Result is stored in rax
    mov rdi, name
    call strlen

    ; If user does not do an input, string length should be zero so skip newline removal
    cmp rax, 0
    je name_newline_removed

    ; if the end of name does not have a newline charcter(10 in ASCII), skip the newline removal
    cmp byte [name + rax - 1], 10
    jne name_newline_removed

    ; replace the newline character with a 0, or terminating character
    mov byte [name + rax - 1], 0

    ; continue after newline character for name is gone
    name_newline_removed:

    ; Print title prompt
    mov rax, 0
    mov rdi, string_format
    mov rsi, title_input
    call printf

    ; Get title
    mov rdi, title
    mov rsi, maximum_number_of_characters_for_input
    mov rdx, [stdin]
    call fgets

    ; Remove newline from title through the same process we used for name
    mov rdi, title
    call strlen

    ; if the end of line char is found, the newline was removed
    cmp rax, 0
    je title_newline_removed
    ; if the last bit of the string is not a newline, then the newline was removed
    cmp byte [title + rax - 1], 10
    jne title_newline_removed

    ; if the execution sequence got past the last two statements, there must be a newline char, so we will remove it by inserting a end of string character at the end
    mov byte [title + rax - 1], 0

    title_newline_removed:


    ; Print greeting
    mov rax, 0
    mov rdi, greetings_output
    mov rsi, title
    mov rdx, name
    call printf

    ; Print program description message
    mov rax, 0
    mov rdi, string_format
    mov rsi, program_message
    call printf

    ; Print amount of numbers query
    mov rax, 0
    mov rdi, string_format
    mov rsi, num_in_array_message
    call printf

    ; Get the amount of random numbers to be generated
    mov rdi, amount_of_random_nums
    mov rsi, maximum_number_of_characters_for_input
    mov rdx, [stdin]
    call fgets

    ; Convert amount of random nums to a integer. 
    ; Function is non-varadic so no mov rax, 0, and result is stored in rax
    mov rdi, amount_of_random_nums
    call atoi

    ; move converted string into amount of random nums
    mov [amount_of_random_nums], rax

    ; Code to check whether or not the array size is less than 0, or greater than 100.
    ; If it is, then user will input another size, else size is valid and we continue
    jmp array_size_validation
    array_size_validation:

        cmp rax, max_size_of_array
        jg try_again

        cmp rax, 0
        jle try_again

        jmp array_is_valid
    
    try_again:
        ; Print try again prompt
        mov rax, 0
        mov rdi, string_format
        mov rsi, try_again_input_message
        call printf

        ; Get input from the command line and store it in amount of random nums
        mov rdi, amount_of_random_nums
        mov rsi, maximum_number_of_characters_for_input
        mov rdx, [stdin]
        call fgets

        ; Convert amount of random nums to a integer. Function is non-varadic so no mov rax, 0, and result is stored in rax
        mov rdi, amount_of_random_nums
        call atoi

        ; move converted string into amount of random nums
        mov [amount_of_random_nums], rax

        jmp array_size_validation
    
    array_is_valid:

    ; Print numbers have been stored message
    mov rax, 0
    mov rdi, string_format
    mov rsi, display_array_message
    call printf

    ; Fill the array, with amount of random numbers to be filled, and the array we are filling
    mov rdi, array
    mov rsi, [amount_of_random_nums]
    call fill_random_array

    ; array of random numbers stored in rsi, amount of random nums stored in rdi
    mov rdi, array
    mov rsi, [amount_of_random_nums] 
    call show_array

    ; normalize the array with the same arguments used above
    mov rdi, array
    mov rsi, [amount_of_random_nums] 
    call normalize_array

    ; print normalize array message
    mov rax, 0
    mov rdi, string_format
    mov rsi, normalize_array_message
    call printf

    ; show the normalized array
    mov rdi, array
    mov rsi, [amount_of_random_nums]
    call show_array

    ; Print message to say we are sorting the array
    mov rax, 0
    mov rdi, string_format
    mov rsi, sort_array_message
    call printf

    ; Sort the array via the sort.cpp function, using selection sort
    mov rdi, array
    mov rsi, [amount_of_random_nums]
    call selection_sort

    ; show the sorted array
    mov rdi, array
    mov rsi, [amount_of_random_nums]
    call show_array

    mov rax, 0
    mov rdi, goodbye_message
    mov rsi, title
    call printf

    mov rax, name


    delete_activation_record
    ret

