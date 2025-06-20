#!/bin/tcsh -f

echo "running all compiles and opening verdi"

sleep 2

make compile_fifo
echo "compiled"
make compile_verdi_fifo
echo "compiled verdi"
make sim
echo "made sim"
echo "making verdi!"
make waves_verdi

echo "exited verdi"
