#Program name 
#Author
#THis file is 

rm * .o
rm *.out

nasm -f elf64 -l average.lis -o average.o average.asm

gcc -m64 -Wall -no-pie -o driver.o -std=c20 driver.c

gcc -m64 -no-pie -o learn.out average.o driver.o -std=c20 