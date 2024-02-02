#include <stdio.h>
#include <string.h>
#include <stdlib.h>

extern unsigned long average();

int main(int argc, const char* argv[]) 
{
    printf("Welcome to Estimating Driving time maintained by Thomas Nguyen\n");
    double  result = 0;
    result = average();    
    printf("The driver has received this number %lf and will keep it for future use.\n",  result);
    printf("Have a great day.\n\n");
    printf("A zero will be sent to the operating system as a signal of a successful execution.\n\n");
    return 0;
}