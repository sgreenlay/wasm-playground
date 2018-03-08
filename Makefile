all: main.wasm

llvm=C:\Users\sgree\Downloads\LLVM\build\Release\bin
binaryen=C:\Users\sgree\Downloads\Binaryen\build\bin

main.s: main.cpp
  $(llvm)\clang++ -emit-llvm --target=wasm32-unknown-unknown-elf -nostdlib -S main.cpp

main.ll: main.s
  $(llvm)\llc -march=wasm32 -o main.s main.ll

main.wast: main.ll
  $(binaryen)\s2wasm --allocate-stack 1000000 -o main.wast main.s

main.wasm: main.wast
  $(binaryen)\wasm-as -o main.wasm main.wast