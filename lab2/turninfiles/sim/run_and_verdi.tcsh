#!/bin/tcsh

echo "running all compiles and opening verdi"

sleep 5

make compile_top
echo "compiled"
make compile_verdi_top
echo "compiled verdi"
make sim
echo "made sim"
echo "making verdi!"
make waves_verdi &

echo "exited verdi"
