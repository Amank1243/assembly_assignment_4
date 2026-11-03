
echo "Remove old executable files if there are any"
rm -f *.out


echo "Assemble the X86 file series.asm"
nasm -f elf64 -l series.lis -o series.o series.asm

echo "Assemble the X86 file taylor.asm"
nasm -f elf64 -l taylor.lis -o taylor.o taylor.asm

echo "Compile the Cpp file main.cpp"
g++ -m64 -Wall -no-pie -o main.o -c main.cpp

echo "Link all object files together"
g++ -m64 -no-pie -o go.out taylor.o series.o main.o \
    -Wall -z noexecstack -lm


echo "The Non-deterministic Random Numbers program will now run"
./go.out