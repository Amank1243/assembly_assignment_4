/*
 * Program Name: Assignment 4 - Taylor Series
 * This program demonstrates hybrid programming using C++ and x86-64
 * assembly to approximate e^x using a Taylor series.
 * Copyright (C) 2026 Aman Khajuria
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 3
 * as published by the Free Software Foundation.
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 * See the GNU General Public License for more details.
 * A copy of the GNU General Public License v3 is available here:
 * <https://www.gnu.org/licenses/>.
 *
 * Author Information:
 * Name: Aman Khajuria
 * CWID: 812144988
 * Section(s): CPSC 240-#8, CPSC 240-#7
 * Email: akhajuria@csu.fullerton.edu
 *
 * Program Information:
 * Name: Assignment 4 - Taylor Series
 * Languages: C++, x86-64 Assembly, Bash
 * Completion Date: 11/06/2026
 *
 * Program's Purpose:
 * This program approximates e^x using a Taylor series consisting
 * of n+1 terms. The assembly functions obtain user input and
 * calculate the approximation.
 *
 * Project Information:
 * Files: main.cpp, series.asm, taylor.asm, macro.inc, r.sh
 * Status: Complete
 *
 * Execution:
 * Run ./r.sh.
 * The script assembles, compiles, links, and executes the program.
 *
 * File's Purpose:
 * This file contains the main function, which serves as the C++
 * driver. It calls the series assembly function, receives the
 * computed approximation as a double, and displays the result.
 */


#include <iostream>

extern "C" double series();

int main() {
    double number = series();
    
    std::cout << std::fixed;
    std::cout << std::cout.precision(5);
    std::cout << "The driver received this number " << number << ", and will keep it." << std::endl;
    std::cout << "Goodbye";

    return 0;
}