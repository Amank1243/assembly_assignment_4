; Program Name: Assignment 4 - Taylor Series
; This program demonstrates hybrid programming using C++ and x86-64 assembly
; to approximate e^x using a Taylor series.
; Copyright (C) 2026 Aman Khajuria
;
; This program is free software: you can redistribute it and/or modify it
; under the terms of the GNU General Public License version 3 as published
; by the Free Software Foundation.
; This program is distributed in the hope that it will be useful, but
; WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
; See the GNU General Public License for more details.
; A copy of the GNU General Public License v3 is available here:
; <https://www.gnu.org/licenses/>.
;
; Author Information:
; Name: Aman Khajuria
; CWID: 812144988
; Section(s): CPSC 240-#8, CPSC 240-#7
; Email: akhajuria@csu.fullerton.edu
;
; Program Information:
; Name: Assignment 4 - Taylor Series
; Languages: C++, x86-64 Assembly, Bash
; Completion Date: 11/06/2026
;
; Program's Purpose:
; This program approximates e^x using a Taylor series consisting of
; n+1 terms. It accepts a floating-point value x and an integer n
; from the user, computes the approximation, and displays the result
; with eight digits after the decimal point.
;
; Project Information:
; Files: main.cpp, series.asm, taylor.asm, macro.inc, r.sh
; Status: Complete
;
; Execution:
; Run ./r.sh.
; The script assembles, compiles, links, and executes the program.
;
; File's Purpose:
; This file contains the series function, which obtains the user's
; input values x and n, passes them to the taylor function, receives
; the computed approximation, displays it, and returns the result
; to the C++ driver.


%include "macro.inc"

extern printf
extern fgets
extern stdin
extern atof
extern atoi
extern taylor

global series

maximum_number_of_characters_for_input equ 100

segment .data

    welcome_message db "Welcome to Taylor Series by Aman Khajuria.", 10, 0

    software_info_message db 10, "This software will compute any power of e that you may need.", 10, 0

    x_float_input_msg db 10, "Please enter a float number value for x: ", 0

    number_of_terms_msg db 10, "Please enter the number of terms to include in the Taylor sum: ", 0

    waiting_message db 10, "Thank you for waiting", 10, 0

    result_message db 10, "The computed approximation of e^x is %.8f with precision of 8 digits right of the point.", 10, 0

    thank_you_message db 10, "Thank you for using the Khajuria exponential calculator.", 10, 0

    return_message db 10, "Please return another day. The computed value will be sent to the caller function.", 10, 0

    invalid_message db 10, "Please enter a positive number of terms.", 10, 0

    string_format db "%s", 0

segment .bss

    ; String input buffer for fgets
    input_buffer resb 100

segment .text

series:

    create_activation_record

    ; Print welcome message
    mov rax, 0
    mov rdi, string_format
    mov rsi, welcome_message
    call printf

    ; Print software information
    mov rax, 0
    mov rdi, string_format
    mov rsi, software_info_message
    call printf

    ; Ask for x
    mov rax, 0
    mov rdi, string_format
    mov rsi, x_float_input_msg
    call printf

    ; Read x as a string
    mov rdi, input_buffer
    mov rsi, maximum_number_of_characters_for_input
    mov rdx, [stdin]
    call fgets

    ; Convert x to a double
    mov rdi, input_buffer
    call atof

    ; Save x in xmm14 without changing its bits
    movsd xmm14, xmm0

    ; Ask for the number of terms
    mov rax, 0
    mov rdi, string_format
    mov rsi, number_of_terms_msg
    call printf

    ; Read n as a string
    mov rdi, input_buffer
    mov rsi, maximum_number_of_characters_for_input
    mov rdx, [stdin]
    call fgets

    ; Convert n to an integer
    mov rdi, input_buffer
    call atoi

    ; Make sure n is positive or zero, as in the formula given n can equal zero
    cmp eax, 0
    jl invalid_input

    ; Save n in r15
    mov r15d, eax

    ; Pass x to taylor in xmm0
    movsd xmm0, xmm14

    ; Pass n to taylor in rdi
    mov rdi, r15

    ; Call taylor
    call taylor

    ; Save returned double in xmm14
    movsd xmm14, xmm0

    ; Print waiting message
    mov rax, 0
    mov rdi, string_format
    mov rsi, waiting_message
    call printf

    ; Print computed approximation
    movsd xmm0, xmm14
    mov rax, 1
    mov rdi, result_message
    call printf

    ; Print thank you message
    mov rax, 0
    mov rdi, string_format
    mov rsi, thank_you_message
    call printf

    ; Print return message
    mov rax, 0
    mov rdi, string_format
    mov rsi, return_message
    call printf

    ; Return the computed double to main.cpp
    movsd xmm0, xmm14

    jmp series_done

invalid_input:

    ; Display invalid input message
    mov rax, 0
    mov rdi, string_format
    mov rsi, invalid_message
    call printf

    ; Return 0.0
    pxor xmm0, xmm0

series_done:

    delete_activation_record
    ret
