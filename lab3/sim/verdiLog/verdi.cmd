simSetSimulator "-vcssv" -exec "./simv" -args "-lca"
debImport "-dbdir" "./simv.daidir"
debLoadSimResult /home/a24541_asu/ADDV/lab3/sim/novas.fsdb
wvCreateWindow
verdiWindowResize -win $_Verdi_1 "820" "277" "900" "700"
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvSelectGroup -win $_nWave2 {G1}
verdiSetActWin -win $_nWave2
wvGetSignalOpen -win $_nWave2
wvGetSignalSetScope -win $_nWave2 "/FPMult_tb_fp8_no_exceptions"
wvGetSignalSetScope -win $_nWave2 "/FPMult_tb_fp8_no_exceptions/uut/AlignModule"
wvGetSignalSetScope -win $_nWave2 \
           "/FPMult_tb_fp8_no_exceptions/uut/PrealignModule"
wvSetPosition -win $_nWave2 {("G1" 8)}
wvSetPosition -win $_nWave2 {("G1" 8)}
wvAddSignal -win $_nWave2 -clear
wvAddSignal -win $_nWave2 -group {"G1" \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/A\[7:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/Aout\[6:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/B\[7:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/Bout\[6:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/Sa} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/Sb} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/ShiftDet\[5:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/operation} \
}
wvAddSignal -win $_nWave2 -group {"G2" \
}
wvSelectSignal -win $_nWave2 {( "G1" 1 2 3 4 5 6 7 8 )} 
wvSetPosition -win $_nWave2 {("G1" 8)}
wvGetSignalClose -win $_nWave2
wvSetCursor -win $_nWave2 55.118735 -snap {("G1" 1)}
wvSetCursor -win $_nWave2 53.435720 -snap {("G1" 1)}
wvSelectSignal -win $_nWave2 {( "G1" 1 )} 
wvSelectSignal -win $_nWave2 {( "G1" 1 )} 
wvSetRadix -win $_nWave2 -format Bin
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "FPMult_tb_fp8_no_exceptions.uut.PrealignModule" -win $_nTrace1
srcSetScope "FPMult_tb_fp8_no_exceptions.uut.PrealignModule" -delim "." -win \
           $_nTrace1
srcHBSelect "FPMult_tb_fp8_no_exceptions.uut.PrealignModule" -win $_nTrace1
wvSelectSignal -win $_nWave2 {( "G1" 2 )} 
verdiSetActWin -win $_nWave2
wvSelectSignal -win $_nWave2 {( "G1" 2 )} 
wvSetRadix -win $_nWave2 -format Bin
verdiWindowResize -win $_Verdi_1 "779" "111" "900" "700"
srcHBSelect "FPMult_tb_fp8_no_exceptions" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "FPMult_tb_fp8_no_exceptions" -win $_nTrace1
srcSetScope "FPMult_tb_fp8_no_exceptions" -delim "." -win $_nTrace1
srcHBSelect "FPMult_tb_fp8_no_exceptions" -win $_nTrace1
wvSetCursor -win $_nWave2 62.692301 -snap {("G1" 7)}
verdiSetActWin -win $_nWave2
wvSetCursor -win $_nWave2 161.569421 -snap {("G1" 5)}
wvSetCursor -win $_nWave2 34.081050 -snap {("G1" 5)}
wvSetCursor -win $_nWave2 47.124414 -snap {("G1" 5)}
wvSelectSignal -win $_nWave2 {( "G1" 5 )} 
wvSetCursor -win $_nWave2 305.046433 -snap {("G1" 7)}
wvSetCursor -win $_nWave2 92.565814 -snap {("G1" 8)}
wvSetCursor -win $_nWave2 72.369637 -snap {("G1" 8)}
wvGetSignalOpen -win $_nWave2
wvGetSignalSetScope -win $_nWave2 "/FPMult_tb_fp8_no_exceptions"
wvGetSignalSetScope -win $_nWave2 "/FPMult_tb_fp8_no_exceptions/uut"
wvGetSignalSetScope -win $_nWave2 \
           "/FPMult_tb_fp8_no_exceptions/uut/PrealignModule"
wvGetSignalSetScope -win $_nWave2 "/FPMult_tb_fp8_no_exceptions/uut/AlignModule"
wvSetPosition -win $_nWave2 {("G2" 8)}
wvSetPosition -win $_nWave2 {("G2" 8)}
wvAddSignal -win $_nWave2 -clear
wvAddSignal -win $_nWave2 -group {"G1" \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/A\[7:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/Aout\[6:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/B\[7:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/Bout\[6:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/Sa} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/Sb} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/ShiftDet\[5:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/operation} \
}
wvAddSignal -win $_nWave2 -group {"G2" \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/A\[6:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/B\[6:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/CExp\[2:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/MaxAB} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/Mmax\[3:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/Mmin\[3:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/ShiftDet\[5:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/Shift\[2:0\]} \
}
wvAddSignal -win $_nWave2 -group {"G3" \
}
wvSelectSignal -win $_nWave2 {( "G2" 1 2 3 4 5 6 7 8 )} 
wvSetPosition -win $_nWave2 {("G2" 8)}
wvSetCursor -win $_nWave2 111.920484 -snap {("G2" 0)}
wvSelectSignal -win $_nWave2 {( "G2" 1 2 3 4 5 6 7 8 )} 
wvSetRadix -win $_nWave2 -format Bin
srcHBSelect "FPMult_tb_fp8_no_exceptions.uut.AlignModule" -win $_nTrace1
srcSetScope "FPMult_tb_fp8_no_exceptions.uut.AlignModule" -delim "." -win \
           $_nTrace1
srcHBSelect "FPMult_tb_fp8_no_exceptions.uut.AlignModule" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
wvGetSignalSetScope -win $_nWave2 "/FPMult_tb_fp8_no_exceptions/uut/AlignShift1"
verdiSetActWin -win $_nWave2
wvSetPosition -win $_nWave2 {("G2" 3)}
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G3" 3)}
wvSetPosition -win $_nWave2 {("G3" 3)}
wvAddSignal -win $_nWave2 -clear
wvAddSignal -win $_nWave2 -group {"G1" \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/A\[7:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/Aout\[6:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/B\[7:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/Bout\[6:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/Sa} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/Sb} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/ShiftDet\[5:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/operation} \
}
wvAddSignal -win $_nWave2 -group {"G2" \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/A\[6:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/B\[6:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/CExp\[2:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/MaxAB} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/Mmax\[3:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/Mmin\[3:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/ShiftDet\[5:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/Shift\[2:0\]} \
}
wvAddSignal -win $_nWave2 -group {"G3" \
{/FPMult_tb_fp8_no_exceptions/uut/AlignShift1/MminP\[3:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignShift1/Mmin\[4:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignShift1/Shift\[2:0\]} \
}
wvAddSignal -win $_nWave2 -group {"G4" \
}
wvSelectSignal -win $_nWave2 {( "G3" 1 2 3 )} 
wvSetPosition -win $_nWave2 {("G3" 3)}
wvGetSignalSetScope -win $_nWave2 "/FPMult_tb_fp8_no_exceptions/uut/AlignShift2"
wvSetPosition -win $_nWave2 {("G4" 3)}
wvSetPosition -win $_nWave2 {("G4" 3)}
wvAddSignal -win $_nWave2 -clear
wvAddSignal -win $_nWave2 -group {"G1" \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/A\[7:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/Aout\[6:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/B\[7:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/Bout\[6:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/Sa} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/Sb} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/ShiftDet\[5:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/operation} \
}
wvAddSignal -win $_nWave2 -group {"G2" \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/A\[6:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/B\[6:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/CExp\[2:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/MaxAB} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/Mmax\[3:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/Mmin\[3:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/ShiftDet\[5:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/Shift\[2:0\]} \
}
wvAddSignal -win $_nWave2 -group {"G3" \
{/FPMult_tb_fp8_no_exceptions/uut/AlignShift1/MminP\[3:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignShift1/Mmin\[4:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignShift1/Shift\[2:0\]} \
}
wvAddSignal -win $_nWave2 -group {"G4" \
{/FPMult_tb_fp8_no_exceptions/uut/AlignShift2/MminP\[4:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignShift2/Mmin\[4:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignShift2/Shift\[1:0\]} \
}
wvAddSignal -win $_nWave2 -group {"G5" \
}
wvSelectSignal -win $_nWave2 {( "G4" 1 2 3 )} 
wvSetPosition -win $_nWave2 {("G4" 3)}
wvGetSignalSetScope -win $_nWave2 \
           "/FPMult_tb_fp8_no_exceptions/uut/ExecutionModule"
wvSetPosition -win $_nWave2 {("G5" 9)}
wvSetPosition -win $_nWave2 {("G5" 9)}
wvAddSignal -win $_nWave2 -clear
wvAddSignal -win $_nWave2 -group {"G1" \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/A\[7:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/Aout\[6:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/B\[7:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/Bout\[6:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/Sa} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/Sb} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/ShiftDet\[5:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/operation} \
}
wvAddSignal -win $_nWave2 -group {"G2" \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/A\[6:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/B\[6:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/CExp\[2:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/MaxAB} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/Mmax\[3:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/Mmin\[3:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/ShiftDet\[5:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/Shift\[2:0\]} \
}
wvAddSignal -win $_nWave2 -group {"G3" \
{/FPMult_tb_fp8_no_exceptions/uut/AlignShift1/MminP\[3:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignShift1/Mmin\[4:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignShift1/Shift\[2:0\]} \
}
wvAddSignal -win $_nWave2 -group {"G4" \
{/FPMult_tb_fp8_no_exceptions/uut/AlignShift2/MminP\[4:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignShift2/Mmin\[4:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignShift2/Shift\[1:0\]} \
}
wvAddSignal -win $_nWave2 -group {"G5" \
{/FPMult_tb_fp8_no_exceptions/uut/ExecutionModule/MaxAB} \
{/FPMult_tb_fp8_no_exceptions/uut/ExecutionModule/Mmax\[3:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/ExecutionModule/Mmin\[4:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/ExecutionModule/OpMode} \
{/FPMult_tb_fp8_no_exceptions/uut/ExecutionModule/Opr} \
{/FPMult_tb_fp8_no_exceptions/uut/ExecutionModule/PSgn} \
{/FPMult_tb_fp8_no_exceptions/uut/ExecutionModule/Sa} \
{/FPMult_tb_fp8_no_exceptions/uut/ExecutionModule/Sb} \
{/FPMult_tb_fp8_no_exceptions/uut/ExecutionModule/Sum\[8:0\]} \
}
wvAddSignal -win $_nWave2 -group {"G6" \
}
wvSelectSignal -win $_nWave2 {( "G5" 1 2 3 4 5 6 7 8 9 )} 
wvSetPosition -win $_nWave2 {("G5" 9)}
wvSelectSignal -win $_nWave2 {( "G5" 1 2 3 4 5 6 7 8 9 )} 
wvSetRadix -win $_nWave2 -format Bin
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "FPMult_tb_fp8_no_exceptions" -win $_nTrace1
srcSetScope "FPMult_tb_fp8_no_exceptions" -delim "." -win $_nTrace1
srcHBSelect "FPMult_tb_fp8_no_exceptions" -win $_nTrace1
wvGetSignalSetScope -win $_nWave2 \
           "/FPMult_tb_fp8_no_exceptions/uut/NormalizeModule"
verdiSetActWin -win $_nWave2
wvSetPosition -win $_nWave2 {("G6" 3)}
wvSetPosition -win $_nWave2 {("G6" 3)}
wvAddSignal -win $_nWave2 -clear
wvAddSignal -win $_nWave2 -group {"G1" \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/A\[7:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/Aout\[6:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/B\[7:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/Bout\[6:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/Sa} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/Sb} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/ShiftDet\[5:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/operation} \
}
wvAddSignal -win $_nWave2 -group {"G2" \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/A\[6:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/B\[6:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/CExp\[2:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/MaxAB} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/Mmax\[3:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/Mmin\[3:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/ShiftDet\[5:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/Shift\[2:0\]} \
}
wvAddSignal -win $_nWave2 -group {"G3" \
{/FPMult_tb_fp8_no_exceptions/uut/AlignShift1/MminP\[3:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignShift1/Mmin\[4:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignShift1/Shift\[2:0\]} \
}
wvAddSignal -win $_nWave2 -group {"G4" \
{/FPMult_tb_fp8_no_exceptions/uut/AlignShift2/MminP\[4:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignShift2/Mmin\[4:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignShift2/Shift\[1:0\]} \
}
wvAddSignal -win $_nWave2 -group {"G5" \
{/FPMult_tb_fp8_no_exceptions/uut/ExecutionModule/MaxAB} \
{/FPMult_tb_fp8_no_exceptions/uut/ExecutionModule/Mmax\[3:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/ExecutionModule/Mmin\[4:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/ExecutionModule/OpMode} \
{/FPMult_tb_fp8_no_exceptions/uut/ExecutionModule/Opr} \
{/FPMult_tb_fp8_no_exceptions/uut/ExecutionModule/PSgn} \
{/FPMult_tb_fp8_no_exceptions/uut/ExecutionModule/Sa} \
{/FPMult_tb_fp8_no_exceptions/uut/ExecutionModule/Sb} \
{/FPMult_tb_fp8_no_exceptions/uut/ExecutionModule/Sum\[8:0\]} \
}
wvAddSignal -win $_nWave2 -group {"G6" \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeModule/Mmin\[8:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeModule/Shift\[2:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeModule/Sum\[8:0\]} \
}
wvAddSignal -win $_nWave2 -group {"G7" \
}
wvSelectSignal -win $_nWave2 {( "G6" 1 2 3 )} 
wvSetPosition -win $_nWave2 {("G6" 3)}
wvGetSignalSetScope -win $_nWave2 \
           "/FPMult_tb_fp8_no_exceptions/uut/NormalizeShift1"
wvGetSignalSetScope -win $_nWave2 \
           "/FPMult_tb_fp8_no_exceptions/uut/NormalizeShift2"
wvGetSignalSetScope -win $_nWave2 \
           "/FPMult_tb_fp8_no_exceptions/uut/PrealignModule"
wvGetSignalSetScope -win $_nWave2 "/FPMult_tb_fp8_no_exceptions/uut/RoundModule"
wvSetPosition -win $_nWave2 {("G9" 20)}
wvSetPosition -win $_nWave2 {("G9" 20)}
wvAddSignal -win $_nWave2 -clear
wvAddSignal -win $_nWave2 -group {"G1" \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/A\[7:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/Aout\[6:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/B\[7:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/Bout\[6:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/Sa} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/Sb} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/ShiftDet\[5:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/operation} \
}
wvAddSignal -win $_nWave2 -group {"G2" \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/A\[6:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/B\[6:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/CExp\[2:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/MaxAB} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/Mmax\[3:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/Mmin\[3:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/ShiftDet\[5:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/Shift\[2:0\]} \
}
wvAddSignal -win $_nWave2 -group {"G3" \
{/FPMult_tb_fp8_no_exceptions/uut/AlignShift1/MminP\[3:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignShift1/Mmin\[4:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignShift1/Shift\[2:0\]} \
}
wvAddSignal -win $_nWave2 -group {"G4" \
{/FPMult_tb_fp8_no_exceptions/uut/AlignShift2/MminP\[4:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignShift2/Mmin\[4:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignShift2/Shift\[1:0\]} \
}
wvAddSignal -win $_nWave2 -group {"G5" \
{/FPMult_tb_fp8_no_exceptions/uut/ExecutionModule/MaxAB} \
{/FPMult_tb_fp8_no_exceptions/uut/ExecutionModule/Mmax\[3:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/ExecutionModule/Mmin\[4:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/ExecutionModule/OpMode} \
{/FPMult_tb_fp8_no_exceptions/uut/ExecutionModule/Opr} \
{/FPMult_tb_fp8_no_exceptions/uut/ExecutionModule/PSgn} \
{/FPMult_tb_fp8_no_exceptions/uut/ExecutionModule/Sa} \
{/FPMult_tb_fp8_no_exceptions/uut/ExecutionModule/Sb} \
{/FPMult_tb_fp8_no_exceptions/uut/ExecutionModule/Sum\[8:0\]} \
}
wvAddSignal -win $_nWave2 -group {"G6" \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeModule/Mmin\[8:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeModule/Shift\[2:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeModule/Sum\[8:0\]} \
}
wvAddSignal -win $_nWave2 -group {"G7" \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeShift1/MminP\[8:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeShift1/Mmin\[8:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeShift1/Shift\[2:0\]} \
}
wvAddSignal -win $_nWave2 -group {"G8" \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeShift2/CExp\[2:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeShift2/ExpOF\[3:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeShift2/ExpOK\[3:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeShift2/FG} \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeShift2/MSBShift} \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeShift2/NegE} \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeShift2/NormE\[3:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeShift2/NormM\[3:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeShift2/PSSum\[8:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeShift2/R} \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeShift2/S} \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeShift2/Shift\[2:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeShift2/ZeroSum} \
}
wvAddSignal -win $_nWave2 -group {"G9" \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/Ctrl} \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/EOF} \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/ExpAdd} \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/FSgn} \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/Fsgn} \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/G} \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/MaxAB} \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/NormE\[3:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/NormM\[3:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/R} \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/RoundE\[3:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/RoundM\[3:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/RoundOF} \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/RoundUp} \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/RoundUpM\[4:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/S} \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/Sa} \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/Sb} \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/Z\[7:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/ZeroSum} \
}
wvAddSignal -win $_nWave2 -group {"G10" \
}
wvSelectSignal -win $_nWave2 {( "G9" 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 \
           18 19 20 )} 
wvSetPosition -win $_nWave2 {("G9" 20)}
wvGetSignalSetScope -win $_nWave2 "/FPMult_tb_fp8_no_exceptions/uut/AlignModule"
wvGetSignalSetScope -win $_nWave2 \
           "/FPMult_tb_fp8_no_exceptions/uut/Exceptionmodule"
wvSetPosition -win $_nWave2 {("G10" 13)}
wvSetPosition -win $_nWave2 {("G10" 13)}
wvAddSignal -win $_nWave2 -clear
wvAddSignal -win $_nWave2 -group {"G1" \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/A\[7:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/Aout\[6:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/B\[7:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/Bout\[6:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/Sa} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/Sb} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/ShiftDet\[5:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/operation} \
}
wvAddSignal -win $_nWave2 -group {"G2" \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/A\[6:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/B\[6:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/CExp\[2:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/MaxAB} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/Mmax\[3:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/Mmin\[3:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/ShiftDet\[5:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/Shift\[2:0\]} \
}
wvAddSignal -win $_nWave2 -group {"G3" \
{/FPMult_tb_fp8_no_exceptions/uut/AlignShift1/MminP\[3:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignShift1/Mmin\[4:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignShift1/Shift\[2:0\]} \
}
wvAddSignal -win $_nWave2 -group {"G4" \
{/FPMult_tb_fp8_no_exceptions/uut/AlignShift2/MminP\[4:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignShift2/Mmin\[4:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignShift2/Shift\[1:0\]} \
}
wvAddSignal -win $_nWave2 -group {"G5" \
{/FPMult_tb_fp8_no_exceptions/uut/ExecutionModule/MaxAB} \
{/FPMult_tb_fp8_no_exceptions/uut/ExecutionModule/Mmax\[3:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/ExecutionModule/Mmin\[4:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/ExecutionModule/OpMode} \
{/FPMult_tb_fp8_no_exceptions/uut/ExecutionModule/Opr} \
{/FPMult_tb_fp8_no_exceptions/uut/ExecutionModule/PSgn} \
{/FPMult_tb_fp8_no_exceptions/uut/ExecutionModule/Sa} \
{/FPMult_tb_fp8_no_exceptions/uut/ExecutionModule/Sb} \
{/FPMult_tb_fp8_no_exceptions/uut/ExecutionModule/Sum\[8:0\]} \
}
wvAddSignal -win $_nWave2 -group {"G6" \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeModule/Mmin\[8:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeModule/Shift\[2:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeModule/Sum\[8:0\]} \
}
wvAddSignal -win $_nWave2 -group {"G7" \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeShift1/MminP\[8:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeShift1/Mmin\[8:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeShift1/Shift\[2:0\]} \
}
wvAddSignal -win $_nWave2 -group {"G8" \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeShift2/CExp\[2:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeShift2/ExpOF\[3:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeShift2/ExpOK\[3:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeShift2/FG} \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeShift2/MSBShift} \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeShift2/NegE} \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeShift2/NormE\[3:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeShift2/NormM\[3:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeShift2/PSSum\[8:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeShift2/R} \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeShift2/S} \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeShift2/Shift\[2:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeShift2/ZeroSum} \
}
wvAddSignal -win $_nWave2 -group {"G9" \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/Ctrl} \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/EOF} \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/ExpAdd} \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/FSgn} \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/Fsgn} \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/G} \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/MaxAB} \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/NormE\[3:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/NormM\[3:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/R} \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/RoundE\[3:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/RoundM\[3:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/RoundOF} \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/RoundUp} \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/RoundUpM\[4:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/S} \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/Sa} \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/Sb} \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/Z\[7:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/ZeroSum} \
}
wvAddSignal -win $_nWave2 -group {"G10" \
{/FPMult_tb_fp8_no_exceptions/uut/Exceptionmodule/DivideByZero} \
{/FPMult_tb_fp8_no_exceptions/uut/Exceptionmodule/EOF} \
{/FPMult_tb_fp8_no_exceptions/uut/Exceptionmodule/Flags\[4:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/Exceptionmodule/Inexact} \
{/FPMult_tb_fp8_no_exceptions/uut/Exceptionmodule/InputExc\[4:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/Exceptionmodule/Invalid} \
{/FPMult_tb_fp8_no_exceptions/uut/Exceptionmodule/NegE} \
{/FPMult_tb_fp8_no_exceptions/uut/Exceptionmodule/Overflow} \
{/FPMult_tb_fp8_no_exceptions/uut/Exceptionmodule/P\[7:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/Exceptionmodule/R} \
{/FPMult_tb_fp8_no_exceptions/uut/Exceptionmodule/S} \
{/FPMult_tb_fp8_no_exceptions/uut/Exceptionmodule/Underflow} \
{/FPMult_tb_fp8_no_exceptions/uut/Exceptionmodule/Z\[7:0\]} \
}
wvAddSignal -win $_nWave2 -group {"G11" \
}
wvSelectSignal -win $_nWave2 {( "G10" 1 2 3 4 5 6 7 8 9 10 11 12 13 )} 
wvSetPosition -win $_nWave2 {("G10" 13)}
wvSetPosition -win $_nWave2 {("G10" 13)}
wvSetPosition -win $_nWave2 {("G10" 13)}
wvAddSignal -win $_nWave2 -clear
wvAddSignal -win $_nWave2 -group {"G1" \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/A\[7:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/Aout\[6:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/B\[7:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/Bout\[6:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/Sa} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/Sb} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/ShiftDet\[5:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/PrealignModule/operation} \
}
wvAddSignal -win $_nWave2 -group {"G2" \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/A\[6:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/B\[6:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/CExp\[2:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/MaxAB} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/Mmax\[3:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/Mmin\[3:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/ShiftDet\[5:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignModule/Shift\[2:0\]} \
}
wvAddSignal -win $_nWave2 -group {"G3" \
{/FPMult_tb_fp8_no_exceptions/uut/AlignShift1/MminP\[3:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignShift1/Mmin\[4:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignShift1/Shift\[2:0\]} \
}
wvAddSignal -win $_nWave2 -group {"G4" \
{/FPMult_tb_fp8_no_exceptions/uut/AlignShift2/MminP\[4:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignShift2/Mmin\[4:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/AlignShift2/Shift\[1:0\]} \
}
wvAddSignal -win $_nWave2 -group {"G5" \
{/FPMult_tb_fp8_no_exceptions/uut/ExecutionModule/MaxAB} \
{/FPMult_tb_fp8_no_exceptions/uut/ExecutionModule/Mmax\[3:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/ExecutionModule/Mmin\[4:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/ExecutionModule/OpMode} \
{/FPMult_tb_fp8_no_exceptions/uut/ExecutionModule/Opr} \
{/FPMult_tb_fp8_no_exceptions/uut/ExecutionModule/PSgn} \
{/FPMult_tb_fp8_no_exceptions/uut/ExecutionModule/Sa} \
{/FPMult_tb_fp8_no_exceptions/uut/ExecutionModule/Sb} \
{/FPMult_tb_fp8_no_exceptions/uut/ExecutionModule/Sum\[8:0\]} \
}
wvAddSignal -win $_nWave2 -group {"G6" \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeModule/Mmin\[8:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeModule/Shift\[2:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeModule/Sum\[8:0\]} \
}
wvAddSignal -win $_nWave2 -group {"G7" \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeShift1/MminP\[8:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeShift1/Mmin\[8:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeShift1/Shift\[2:0\]} \
}
wvAddSignal -win $_nWave2 -group {"G8" \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeShift2/CExp\[2:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeShift2/ExpOF\[3:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeShift2/ExpOK\[3:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeShift2/FG} \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeShift2/MSBShift} \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeShift2/NegE} \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeShift2/NormE\[3:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeShift2/NormM\[3:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeShift2/PSSum\[8:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeShift2/R} \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeShift2/S} \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeShift2/Shift\[2:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/NormalizeShift2/ZeroSum} \
}
wvAddSignal -win $_nWave2 -group {"G9" \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/Ctrl} \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/EOF} \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/ExpAdd} \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/FSgn} \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/Fsgn} \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/G} \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/MaxAB} \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/NormE\[3:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/NormM\[3:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/R} \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/RoundE\[3:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/RoundM\[3:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/RoundOF} \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/RoundUp} \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/RoundUpM\[4:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/S} \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/Sa} \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/Sb} \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/Z\[7:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/RoundModule/ZeroSum} \
}
wvAddSignal -win $_nWave2 -group {"G10" \
{/FPMult_tb_fp8_no_exceptions/uut/Exceptionmodule/DivideByZero} \
{/FPMult_tb_fp8_no_exceptions/uut/Exceptionmodule/EOF} \
{/FPMult_tb_fp8_no_exceptions/uut/Exceptionmodule/Flags\[4:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/Exceptionmodule/Inexact} \
{/FPMult_tb_fp8_no_exceptions/uut/Exceptionmodule/InputExc\[4:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/Exceptionmodule/Invalid} \
{/FPMult_tb_fp8_no_exceptions/uut/Exceptionmodule/NegE} \
{/FPMult_tb_fp8_no_exceptions/uut/Exceptionmodule/Overflow} \
{/FPMult_tb_fp8_no_exceptions/uut/Exceptionmodule/P\[7:0\]} \
{/FPMult_tb_fp8_no_exceptions/uut/Exceptionmodule/R} \
{/FPMult_tb_fp8_no_exceptions/uut/Exceptionmodule/S} \
{/FPMult_tb_fp8_no_exceptions/uut/Exceptionmodule/Underflow} \
{/FPMult_tb_fp8_no_exceptions/uut/Exceptionmodule/Z\[7:0\]} \
}
wvAddSignal -win $_nWave2 -group {"G11" \
}
wvSelectSignal -win $_nWave2 {( "G10" 1 2 3 4 5 6 7 8 9 10 11 12 13 )} 
wvSetPosition -win $_nWave2 {("G10" 13)}
wvGetSignalClose -win $_nWave2
verdiDockWidgetMaximize -dock windowDock_nWave_2
wvSelectSignal -win $_nWave2 {( "G9" 6 )} 
wvScrollUp -win $_nWave2 37
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvSelectSignal -win $_nWave2 {( "G5" 4 )} 
wvSelectSignal -win $_nWave2 {( "G4" 3 )} 
wvSelectGroup -win $_nWave2 {G5}
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvSelectSignal -win $_nWave2 {( "G8" 9 )} 
wvSelectSignal -win $_nWave2 {( "G8" 9 )} 
wvSetRadix -win $_nWave2 -format Bin
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 4
wvScrollDown -win $_nWave2 5
wvScrollDown -win $_nWave2 4
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvSelectSignal -win $_nWave2 {( "G5" 5 )} 
wvSelectSignal -win $_nWave2 {( "G7" 2 )} 
wvSelectSignal -win $_nWave2 {( "G7" 2 )} 
wvSetRadix -win $_nWave2 -format Bin
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvSelectSignal -win $_nWave2 {( "G7" 2 )} 
wvSelectGroup -win $_nWave2 {G6}
wvSelectGroup -win $_nWave2 {G7}
wvSelectGroup -win $_nWave2 {G7}
wvSelectGroup -win $_nWave2 {G7}
wvSelectGroup -win $_nWave2 {G6}
wvSetPosition -win $_nWave2 {("G6" 0)}
wvSetPosition -win $_nWave2 {("G6" 1)}
wvSetPosition -win $_nWave2 {("G6" 2)}
wvSetPosition -win $_nWave2 {("G7" 0)}
wvSetPosition -win $_nWave2 {("G7" 3)}
wvSetPosition -win $_nWave2 {("G8" 2)}
wvSetPosition -win $_nWave2 {("G8" 6)}
wvSetPosition -win $_nWave2 {("G8" 10)}
wvSetPosition -win $_nWave2 {("G9" 2)}
wvSetPosition -win $_nWave2 {("G9" 7)}
wvSetPosition -win $_nWave2 {("G9" 5)}
wvSetPosition -win $_nWave2 {("G9" 3)}
wvSetPosition -win $_nWave2 {("G8" 12)}
wvSetPosition -win $_nWave2 {("G8" 7)}
wvSetPosition -win $_nWave2 {("G8" 2)}
wvSetPosition -win $_nWave2 {("G7" 3)}
wvSetPosition -win $_nWave2 {("G7" 1)}
wvSetPosition -win $_nWave2 {("G6" 3)}
wvSetPosition -win $_nWave2 {("G6" 1)}
wvSetPosition -win $_nWave2 {("G6" 0)}
wvMoveSelected -win $_nWave2
wvSelectAll -win $_nWave2
wvSelectSignal -win $_nWave2 {( "G1" 1 2 3 4 5 6 7 8 )} {( "G2" 1 2 3 4 5 6 7 \
           8 )} {( "G3" 1 2 3 )} {( "G4" 1 2 3 )} {( "G5" 1 2 3 4 5 6 7 8 9 )} \
           {( "G6" 1 2 3 )} {( "G7" 1 2 3 )} {( "G8" 1 2 3 4 5 6 7 8 9 10 11 \
           12 13 )} {( "G9" 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 \
           )} {( "G10" 1 2 3 4 5 6 7 8 9 10 11 12 13 )} 
wvSetRadix -win $_nWave2 -format Bin
wvSetCursor -win $_nWave2 414.757272 -snap {("G9" 0)}
wvSelectSignal -win $_nWave2 {( "G9" 2 )} 
wvScrollDown -win $_nWave2 2
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 6
wvSelectSignal -win $_nWave2 {( "G10" 8 )} 
wvScrollDown -win $_nWave2 0
verdiWindowResize -win $_Verdi_1 "779" "111" "900" "700"
