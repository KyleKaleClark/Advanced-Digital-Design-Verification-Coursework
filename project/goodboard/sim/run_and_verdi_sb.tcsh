#!/bin/tcsh


#little check so i can just keep running my script lol
if ($#argv > 0) then
    if ("$argv[1]" == "bug") then
	set bugmode = 1
	echo "bug on"
    else
	set bugmode = 0
	echo "bug off"
    endif
else
    set bugmode = 0
    echo "bug off"
endif
    


echo "running all compiles and opening verdi"

sleep 5

make compile_fifo_sb
echo "compiled"

if ($bugmode) then
    echo "compile_verdi_fifo_bug_sb"
    make compile_verdi_fifo_bug_sb
else
    echo "compile_verdi_fifo_sb"
    make compile_verdi_fifo_sb
endif


echo "compiled verdi"
make sim
echo "made sim"
echo "making verdi!"
#make waves_verdi

echo "exited verdi"
