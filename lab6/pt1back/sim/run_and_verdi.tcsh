#!/bin/tcsh

echo "clean first"
make clean

echo "running all compiles and opening verdi"

sleep 5

#make comp_and_sim_matmul
echo "compiled"
make compile_verdi_matmul > kyle.log
echo "compiled verdi"
make sim >> kyle.log
echo "made sim"
echo "making verdi!"
#make waves_verdi >>kyle.log

echo "exited verdi"
