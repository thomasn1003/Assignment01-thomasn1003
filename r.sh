#Program name: "Average Driving Speed"
#Author: Thomas Nguyen
#This file is the script file that accompanies the "driver.c" program.

rm * .o
rm * .out

nasm -f elf64  -l average.lis -o average.o average.asm

gcc  -m64  -Wall -no-pie -o driver.o -std=c2x -c driver.c

gcc -m64 -no-pie -o learn.out average.o driver.o -std=c2x -Wall -z noexecstack

chmod +x learn.out
./learn.out