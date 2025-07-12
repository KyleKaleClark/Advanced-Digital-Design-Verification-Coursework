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

make compile_uvm > kyle.log

echo "compiled verdi"
make sim >> kyle.log
echo "made sim"
echo "making verdi!"
#make waves_verdi &
make coverage_verdi &
echo "exited verdi"
