//Author: Thomas Nguyen
//Author email: thomasn1003@csu.fullerton.edu
//Program name: Average Driving Speed
//Programming languages: One module in C, one in X86, and one in bash.
//Date program began: 2024-Jan-11
//Date of last update: 2024-Feb-2
//Files in this program: driver.c, average.asm, r.sh.


//Purpose of this program:
//  This program is to calculate the average speed of Linda Garcia as she drives from Fullerton
//   to Santa Ana to Long Beach and back to Fullerton again

//This file
//  File name: driver.c
//  Language: C language, 202x standardization where x will be a decimal digit.
//  Max page width: 124 columns
//  Compile: gcc -m64 -no-pie -o begin.o -std=c20 -Wall driver.c -c
//  Link: gcc -m64 -no-pie -o learn.out average.o driver.o -std=c20 -Wall -z noexecstack

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

extern double average();

int main(int argc, const char* argv[]) 
{
    printf("Welcome to Average Driving Speed maintained by Thomas Nguyen\n");
    double result = 0.0;
    result = average();    
    printf("The driver has received this number %0.2lf and will keep it for future use.\n", result);
    printf("Have a great day.\n\n");
    printf("A zero will be sent to the operating system as a signal of a successful execution.\n\n");
    return 0;
}