#!/bin/tcsh

echo "running all compiles and opening verdi"

echo "cleaning!"
sleep 5
make clean

make compile_cov > coverage.log
echo "compiled"
make compile_verdi_cov >>coverage.log
echo "compiled verdi"
make sim >>coverage.log
echo "made sim"
echo "making verdi!"
make waves_verdi >> coverage.log &

