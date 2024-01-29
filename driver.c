

#include <stdio.h>

extern unsigned long helloworld();

int main(int argc, const char * argv[])
{
    printf("Welcome to Assignment 1 maintained by Thomas Nguyen\n");
    unsigned long count = 0;
    count = average();
    printf(count);
    printf("The driver has received this number and will keep it for future use.\n")
    printf("Have a great day.\n\n");
    printf("A zero will be sent to the operating system as a signal of a successful execution");
    
}