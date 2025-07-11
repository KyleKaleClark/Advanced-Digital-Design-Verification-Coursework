#!/bin/tcsh


#little check so i can just keep running my script lol
if ($#argv > 0) then
    if ("$argv[1]" == "bug") then
	set bugmode = 1
    
    else
	set bugmode = 0
    endif
else
    set bugmode = 0
endif
    


echo "running all compiles and opening verdi"

sleep 5

make compile_fifo
echo "compiled"

if ($bugmode) then
    make compile_verdi_fifo_bug
else
    make compile_verdi_fifo
endif


echo "compiled verdi"
make sim
echo "made sim"
echo "making verdi!"
#make waves_verdi

echo "exited verdi"
