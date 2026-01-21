#!/bin/sh

rm -f primes fibonacci gcd factorial

echo "[primes]"
../source/petit < primes.pt > primes.ll
llc primes.ll -o primes.s
clang primes.s ../source/io.c -o primes
./primes

echo "[fibonacci]"
../source/petit < fibonacci.pt > fibonacci.ll
llc fibonacci.ll -o fibonacci.s
clang fibonacci.s ../source/io.c -o fibonacci
./fibonacci

echo "[gcd]"
../source/petit < gcd.pt > gcd.ll
llc gcd.ll -o gcd.s
clang gcd.s ../source/io.c -o gcd
./gcd

echo "[factorial]"
../source/petit < factorial.pt > factorial.ll
llc factorial.ll -o factorial.s
clang factorial.s ../source/io.c -o factorial
echo 7 | ./factorial

echo "[turing]"
../source/petit < turing.pt > turing.ll
llc turing.ll -o turing.s
clang turing.s ../source/io.c -o turing
./turing
