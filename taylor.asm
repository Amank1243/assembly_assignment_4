; Program Name: Assignment 4 - Taylor Series
; This library function computes an approximation of e^x using
; a Taylor series implemented in x86-64 assembly.
; Copyright (C) 2026 Aman Khajuria
;
; This library is free software: you can redistribute it and/or modify
; it under the terms of the GNU Lesser General Public License version 3
; as published by the Free Software Foundation.
; This library is distributed in the hope that it will be useful, but
; WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
; See the GNU Lesser General Public License for more details.
; A copy of the GNU Lesser General Public License v3 is available here:
; <https://www.gnu.org/licenses/lgpl-3.0.html>.
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
; This program approximates e^x using a Taylor series consisting
; of n+1 terms. The calculation is performed in a reusable assembly
; library function.
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
; This file contains the taylor function, which receives a
; floating-point value x and an unsigned integer n, computes
; the sum of the Taylor series from k=0 through k=n, and
; returns the approximation as a 64-bit double.
;
; Function Prototype:
; double taylor(double x, unsigned long int n)
;
; Input:
; xmm0 = x (64-bit double)
; rdi  = n (unsigned long integer)
;
; Output:
; xmm0 = approximation of e^x (64-bit double)


global taylor

segment .data

one dq 1.0

segment .text

taylor:

; Initialize the sum to 1.0
movsd xmm1, [one]

; Initialize the current term to 1.0
movsd xmm2, [one]

; Start the loop counter at 1
mov rcx, 1

taylor_loop:

; Check whether n terms have been computed
cmp rcx, rdi
ja taylor_done

; Multiply the current term by x
mulsd xmm2, xmm0

; Convert the integer counter to a double
cvtsi2sd xmm3, rcx

; Divide the current term by the counter
divsd xmm2, xmm3

; Add the new term to the running sum
addsd xmm1, xmm2

; Increment the loop counter
inc rcx

; Repeat the loop
jmp taylor_loop

taylor_done:

; Move the computed sum into xmm0
movsd xmm0, xmm1

; Return to series.asm
ret
