pwd
clang -S -c -g -fno-discard-value-names -emit-llvm Controllers/example.c -o Controllers/example.ll
./wpa -ander -dump-callgraph Controllers/example.ll
