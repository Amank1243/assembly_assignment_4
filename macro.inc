; Program Name: Assignment 3 - Non-deterministic Random Numbers
; This program demonstrates hybrid programming using C, C++, and x86-64 assembly to
; generate, normalize, display, and sort an array of random 64-bit IEEE 754 floating-point numbers.
; Copyright (C) 2026 Aman Khajuria
;
; This program is free software: you can redistribute it and/or modify it under the terms
; of the GNU General Public License version 3 as published by the Free Software Foundation.
; This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
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
; Name: Assignment 3 - Non-deterministic Random Numbers
; Languages: C, C++, x86-64 Assembly, Bash
; Completion Date: 10/12/2026
;
; Program's Purpose:
; This program generates an array of random 64-bit IEEE 754 floating-point numbers.
; The program obtains the user's name, title, and requested array size, generates
; random values while rejecting NaN, and displays them in hexadecimal and scientific
; decimal formats. It then normalizes the values to the range 1.0 - 2.0, sorts
; them in ascending order, and displays the final results.
;
; Project Information:
; Files: main.c, executive.asm, fill_random_array.asm, is_nan.asm, show_array.asm,
;        normalize_array.asm, sort.cpp, macro.inc, r.sh
; Status: Complete
;
; Execution:
; Run ./r.sh.
; The script assembles, compiles, links, and executes the program.
;
; File's Purpose:
; This is a macro file that pushes and pops all registers before putting them to use.


; ------------------------------------------------------------
; Save the general-purpose registers before modifying them.
; ------------------------------------------------------------

%macro create_activation_record 0

    push rbp
    mov rbp, rsp

    push rbx
    push rcx
    push rdx
    push rdi
    push rsi
    push r8
    push r9
    push r10
    push r11
    push r12
    push r13
    push r14
    push r15
    pushf

%endmacro


; ------------------------------------------------------------
; Restore the saved registers before returning to the caller.
; ------------------------------------------------------------

%macro delete_activation_record 0

    popf
    pop r15
    pop r14
    pop r13
    pop r12
    pop r11
    pop r10
    pop r9
    pop r8
    pop rsi
    pop rdi
    pop rdx
    pop rcx
    pop rbx
    pop rbp

%endmacro