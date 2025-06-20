#!/bin/tcsh

echo "running all compiles and opening verdi"

sleep 5

make compile_and_sim_matmul
echo "compiled"
make compile_verdi_matmul
echo "compiled verdi"
make sim
echo "made sim"
echo "making verdi!"
make waves_verdi

echo "exited verdi"
