

echo "Assemble the source file average.asm"
nasm -f elf64  -l average.lis -o average.o average.asm

echo "Compile the source file driver.c"
gcc  -m64  -Wall -no-pie -o driver.o -std=c2x -c driver.c

echo "Link the object modules to create an executable file"
gcc -m64 -no-pie -o learn.out average.o driver.o -std=c2x -Wall -z noexecstack

echo "Execute the program that new students use to understand assembly programming"
chmod +x learn.out
./learn.out

echo "This bash script will now terminate.