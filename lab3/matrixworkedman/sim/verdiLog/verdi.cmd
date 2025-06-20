simSetSimulator "-vcssv" -exec "./simv" -args
debImport "-dbdir" "./simv.daidir"
debLoadSimResult \
           /home/a21164_asu/addv/lab3_pleasegod/matrixworkedman/sim/novas.fsdb
wvCreateWindow
verdiWindowResize -win $_Verdi_1 "199" "84" "2277" "1215"
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
verdiSetActWin -win $_nWave2
wvRestoreSignal -win $_nWave2 \
           "/home/a21164_asu/addv/lab3_pleasegod/matrixworkedman/sim/matrix.rc" \
           -overWriteAutoAlias on -appendSignals on
wvSetCursor -win $_nWave2 509074.987264 -snap {("G1" 3)}
verdiSetActWin -dock widgetDock_<Inst._Tree>
verdiSetActWin -win $_nWave2
srcDeselectAll -win $_nTrace1
srcSelect -signal "done" -line 8 -pos 1 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvSetCursor -win $_nWave2 329235.303107 -snap {("row1" 1)}
verdiSetActWin -win $_nWave2
srcHBSelect "matmul_tb.u_matmul" -win $_nTrace1
srcSetScope "matmul_tb.u_matmul" -delim "." -win $_nTrace1
srcHBSelect "matmul_tb.u_matmul" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "matmul_tb.u_matmul.u_matmul_4x4" -win $_nTrace1
srcSetScope "matmul_tb.u_matmul.u_matmul_4x4" -delim "." -win $_nTrace1
srcHBSelect "matmul_tb.u_matmul.u_matmul_4x4" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "matrixC00" -line 266 -pos 1 -win $_nTrace1
srcAction -pos 265 2 4 -win $_nTrace1 -name "matrixC00" -ctrlKey off
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcDeselectAll -win $_nTrace1
srcSelect -signal "in_a" -line 874 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("row1" 0)}
wvSetPosition -win $_nWave2 {("row1" 1)}
wvSetPosition -win $_nWave2 {("row1" 0)}
wvAddSignal -win $_nWave2 \
           "/matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/pe00/in_a\[7:0\]"
wvSetPosition -win $_nWave2 {("row1" 0)}
wvSetPosition -win $_nWave2 {("row1" 1)}
wvSelectSignal -win $_nWave2 {( "row1" 1 )} 
verdiSetActWin -win $_nWave2
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("row1" 1)}
wvSetPosition -win $_nWave2 {("row1" 0)}
srcHBSelect "matmul_tb.u_matmul.u_matmul_4x4.u_systolic_pe_matrix.pe00.u_mac" \
           -win $_nTrace1
srcSetScope "matmul_tb.u_matmul.u_matmul_4x4.u_systolic_pe_matrix.pe00.u_mac" \
           -delim "." -win $_nTrace1
srcHBSelect "matmul_tb.u_matmul.u_matmul_4x4.u_systolic_pe_matrix.pe00.u_mac" \
           -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "a" -line 884 -pos 1 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G1" 2)}
wvSetPosition -win $_nWave2 {("G1" 3)}
wvSetPosition -win $_nWave2 {("row1" 0)}
wvAddSignal -win $_nWave2 \
           "/matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/pe00/u_mac/a\[7:0\]"
wvSetPosition -win $_nWave2 {("row1" 0)}
wvSetPosition -win $_nWave2 {("row1" 1)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "b" -line 884 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("row1" 0)}
wvSetPosition -win $_nWave2 {("row1" 1)}
wvSetPosition -win $_nWave2 {("row1" 2)}
wvSetPosition -win $_nWave2 {("row1" 1)}
wvAddSignal -win $_nWave2 \
           "/matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/pe00/u_mac/b\[7:0\]"
wvSetPosition -win $_nWave2 {("row1" 1)}
wvSetPosition -win $_nWave2 {("row1" 2)}
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "out" -line 884 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 2)}
wvSetPosition -win $_nWave2 {("row1" 0)}
wvSetPosition -win $_nWave2 {("row1" 1)}
wvSetPosition -win $_nWave2 {("row1" 0)}
wvSetPosition -win $_nWave2 {("row1" 3)}
wvSetPosition -win $_nWave2 {("row1" 2)}
wvAddSignal -win $_nWave2 \
           "/matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/pe00/u_mac/out\[7:0\]"
wvSetPosition -win $_nWave2 {("row1" 2)}
wvSetPosition -win $_nWave2 {("row1" 3)}
wvSelectSignal -win $_nWave2 {( "row1" 2 3 )} 
wvSelectSignal -win $_nWave2 {( "row1" 1 2 3 )} 
verdiWindowResize -win $_Verdi_1 "61" "112" "1391" "1215"
verdiSetActWin -win $_nWave2
wvSelectGroup -win $_nWave2 {row1}
wvSelectSignal -win $_nWave2 {( "row1" 1 )} 
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("row1" 3)}
wvSetPosition -win $_nWave2 {("row1" 2)}
wvSelectSignal -win $_nWave2 {( "row1" 1 )} 
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("row1" 2)}
wvSetPosition -win $_nWave2 {("row1" 1)}
wvSelectSignal -win $_nWave2 {( "row1" 1 )} 
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("row1" 1)}
wvSetPosition -win $_nWave2 {("row1" 0)}
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "a_flop" -line 901 -pos 1 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G1" 2)}
wvSetPosition -win $_nWave2 {("row1" 0)}
wvSetPosition -win $_nWave2 {("row1" 1)}
wvSetPosition -win $_nWave2 {("row1" 0)}
wvAddSignal -win $_nWave2 \
           "/matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/pe00/u_mac/a_flop\[7:0\]"
wvSetPosition -win $_nWave2 {("row1" 0)}
wvSetPosition -win $_nWave2 {("row1" 1)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "b_flop" -line 901 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("row1" 0)}
wvSetPosition -win $_nWave2 {("row1" 1)}
wvAddSignal -win $_nWave2 \
           "/matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/pe00/u_mac/b_flop\[7:0\]"
wvSetPosition -win $_nWave2 {("row1" 1)}
wvSetPosition -win $_nWave2 {("row1" 2)}
verdiSetActWin -win $_nWave2
srcDeselectAll -win $_nTrace1
srcSelect -signal "mult_out" -line 901 -pos 1 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G1" 3)}
wvSetPosition -win $_nWave2 {("row1" 0)}
wvSetPosition -win $_nWave2 {("row1" 2)}
wvAddSignal -win $_nWave2 \
           "/matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/pe00/u_mac/mult_out\[7:0\]"
wvSetPosition -win $_nWave2 {("row1" 2)}
wvSetPosition -win $_nWave2 {("row1" 3)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "mult_result" -line 902 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 3)}
wvSetPosition -win $_nWave2 {("row1" 0)}
wvSetPosition -win $_nWave2 {("row1" 4)}
wvSetPosition -win $_nWave2 {("row1" 5)}
wvSetPosition -win $_nWave2 {("row1" 4)}
wvSetPosition -win $_nWave2 {("row1" 3)}
wvAddSignal -win $_nWave2 \
           "/matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/pe00/u_mac/mult_result\[7:0\]"
wvSetPosition -win $_nWave2 {("row1" 3)}
wvSetPosition -win $_nWave2 {("row1" 4)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "out" -line 902 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("row1" 0)}
wvSetPosition -win $_nWave2 {("G1" 3)}
wvSetPosition -win $_nWave2 {("row1" 0)}
wvSetPosition -win $_nWave2 {("row1" 1)}
wvSetPosition -win $_nWave2 {("row1" 2)}
wvSetPosition -win $_nWave2 {("row1" 3)}
wvSetPosition -win $_nWave2 {("row1" 4)}
wvAddSignal -win $_nWave2 \
           "/matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/pe00/u_mac/out\[7:0\]"
wvSetPosition -win $_nWave2 {("row1" 4)}
wvSetPosition -win $_nWave2 {("row1" 5)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "add_res" -line 902 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("row1" 2)}
wvSetPosition -win $_nWave2 {("row1" 0)}
wvSetPosition -win $_nWave2 {("row1" 4)}
wvSetPosition -win $_nWave2 {("row1" 5)}
wvSetPosition -win $_nWave2 {("row1" 6)}
wvSetPosition -win $_nWave2 {("row1" 5)}
wvSetPosition -win $_nWave2 {("row1" 4)}
wvAddSignal -win $_nWave2 \
           "/matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/pe00/u_mac/add_res\[7:0\]"
wvSetPosition -win $_nWave2 {("row1" 4)}
wvSetPosition -win $_nWave2 {("row1" 5)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "out" -line 902 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 2)}
wvSetPosition -win $_nWave2 {("row1" 0)}
wvSetPosition -win $_nWave2 {("row1" 5)}
wvSetPosition -win $_nWave2 {("row1" 6)}
wvSetPosition -win $_nWave2 {("row1" 5)}
wvSetPosition -win $_nWave2 {("row1" 4)}
wvAddSignal -win $_nWave2 \
           "/matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/pe00/u_mac/out\[7:0\]"
wvSetPosition -win $_nWave2 {("row1" 4)}
wvSetPosition -win $_nWave2 {("row1" 5)}
verdiSetActWin -win $_nWave2
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvSelectSignal -win $_nWave2 {( "row1" 7 )} 
wvSetPosition -win $_nWave2 {("row1" 7)}
wvSetPosition -win $_nWave2 {("row1" 6)}
wvSetPosition -win $_nWave2 {("row1" 5)}
wvSetPosition -win $_nWave2 {("row1" 6)}
wvSetPosition -win $_nWave2 {("row1" 7)}
wvMoveSelected -win $_nWave2
wvSetPosition -win $_nWave2 {("row1" 7)}
wvSelectSignal -win $_nWave2 {( "row1" 1 2 3 4 5 6 7 )} 
wvSaveSignal -win $_nWave2 \
           "/home/a21164_asu/addv/lab3_pleasegod/matrixworkedman/sim/strider.rc"
srcDeselectAll -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcHBSelect "matmul_tb.u_matmul.u_matmul_4x4.u_systolic_pe_matrix.pe00" -win \
           $_nTrace1
srcSetScope "matmul_tb.u_matmul.u_matmul_4x4.u_systolic_pe_matrix.pe00" -delim \
           "." -win $_nTrace1
srcHBSelect "matmul_tb.u_matmul.u_matmul_4x4.u_systolic_pe_matrix.pe00" -win \
           $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "matmul_tb.u_matmul.u_matmul_4x4.u_systolic_pe_matrix" -win $_nTrace1
srcSetScope "matmul_tb.u_matmul.u_matmul_4x4.u_systolic_pe_matrix" -delim "." \
           -win $_nTrace1
srcHBSelect "matmul_tb.u_matmul.u_matmul_4x4.u_systolic_pe_matrix" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "a0" -line 805 -pos 1 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvSetPosition -win $_nWave2 {("G1" 2)}
wvSetPosition -win $_nWave2 {("G1" 3)}
wvSetPosition -win $_nWave2 {("row1" 0)}
wvSetPosition -win $_nWave2 {("row1" 1)}
wvSetPosition -win $_nWave2 {("row1" 0)}
wvAddSignal -win $_nWave2 \
           "/matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/a0\[7:0\]"
wvSetPosition -win $_nWave2 {("row1" 0)}
wvSetPosition -win $_nWave2 {("row1" 1)}
verdiSetActWin -win $_nWave2
wvShowOneTraceSignals -win $_nWave2 -signal \
           "/matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/a0\[7:0\]" \
           -driver
srcDeselectAll -win $_nTrace1
srcSelect -signal "a0" -line 215 -pos 1 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvSetPosition -win $_nWave2 {("G1" 2)}
wvSetPosition -win $_nWave2 {("G1" 3)}
wvSetPosition -win $_nWave2 {("row1" 1)}
wvSetPosition -win $_nWave2 \
           {("row1//matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/a0@270000(1ps)#ActiveDriver" 0)}
wvSetPosition -win $_nWave2 \
           {("row1//matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/a0@270000(1ps)#ActiveDriver" 1)}
wvAddSignal -win $_nWave2 "/matmul_tb/u_matmul/u_matmul_4x4/a0\[7:0\]"
wvSetPosition -win $_nWave2 \
           {("row1//matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/a0@270000(1ps)#ActiveDriver" 1)}
wvSetPosition -win $_nWave2 \
           {("row1//matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/a0@270000(1ps)#ActiveDriver" 2)}
verdiSetActWin -win $_nWave2
wvSelectGroup -win $_nWave2 \
           {row1//matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/a0@270000(1ps)#ActiveDriver}
wvSelectSignal -win $_nWave2 \
           {( "row1//matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/a0@270000(1ps)#ActiveDriver" \
           4 )} 
wvSetPosition -win $_nWave2 \
           {("row1//matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/a0@270000(1ps)#ActiveDriver" 4)}
wvSetPosition -win $_nWave2 \
           {("row1//matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/a0@270000(1ps)#ActiveDriver" 3)}
wvMoveSelected -win $_nWave2
wvSetPosition -win $_nWave2 \
           {("row1//matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/a0@270000(1ps)#ActiveDriver" 3)}
wvSetPosition -win $_nWave2 \
           {("row1//matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/a0@270000(1ps)#ActiveDriver" 4)}
wvUndo -win $_nWave2
wvSetPosition -win $_nWave2 \
           {("row1//matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/a0@270000(1ps)#ActiveDriver" 4)}
wvSetPosition -win $_nWave2 \
           {("row1//matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/a0@270000(1ps)#ActiveDriver" 4)}
wvSetPosition -win $_nWave2 \
           {("row1//matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/a0@270000(1ps)#ActiveDriver" 3)}
wvUndo -win $_nWave2
wvSetPosition -win $_nWave2 \
           {("row1//matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/a0@270000(1ps)#ActiveDriver" 3)}
wvSetPosition -win $_nWave2 \
           {("row1//matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/a0@270000(1ps)#ActiveDriver" 4)}
wvUndo -win $_nWave2
wvSetPosition -win $_nWave2 \
           {("row1//matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/a0@270000(1ps)#ActiveDriver" 4)}
wvSetPosition -win $_nWave2 \
           {("row1//matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/a0@270000(1ps)#ActiveDriver" 4)}
wvSetPosition -win $_nWave2 \
           {("row1//matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/a0@270000(1ps)#ActiveDriver" 3)}
wvUndo -win $_nWave2
wvSetPosition -win $_nWave2 \
           {("row1//matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/a0@270000(1ps)#ActiveDriver" 3)}
wvSetPosition -win $_nWave2 \
           {("row1//matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/a0@270000(1ps)#ActiveDriver" 4)}
wvUndo -win $_nWave2
wvSetPosition -win $_nWave2 \
           {("row1//matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/a0@270000(1ps)#ActiveDriver" 4)}
wvSetPosition -win $_nWave2 \
           {("row1//matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/a0@270000(1ps)#ActiveDriver" 4)}
wvSetPosition -win $_nWave2 \
           {("row1//matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/a0@270000(1ps)#ActiveDriver" 3)}
wvUndo -win $_nWave2
wvSetPosition -win $_nWave2 \
           {("row1//matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/a0@270000(1ps)#ActiveDriver" 3)}
wvSetPosition -win $_nWave2 \
           {("row1//matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/a0@270000(1ps)#ActiveDriver" 4)}
wvUndo -win $_nWave2
wvSetPosition -win $_nWave2 \
           {("row1//matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/a0@270000(1ps)#ActiveDriver" 4)}
wvSetPosition -win $_nWave2 \
           {("row1//matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/a0@270000(1ps)#ActiveDriver" 4)}
wvSetPosition -win $_nWave2 \
           {("row1//matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/a0@270000(1ps)#ActiveDriver" 3)}
wvUndo -win $_nWave2
wvSetPosition -win $_nWave2 \
           {("row1//matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/a0@270000(1ps)#ActiveDriver" 3)}
wvSetPosition -win $_nWave2 \
           {("row1//matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/a0@270000(1ps)#ActiveDriver" 4)}
wvUndo -win $_nWave2
wvSetPosition -win $_nWave2 \
           {("row1//matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/a0@270000(1ps)#ActiveDriver" 4)}
wvSetPosition -win $_nWave2 \
           {("row1//matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/a0@270000(1ps)#ActiveDriver" 4)}
wvSetPosition -win $_nWave2 \
           {("row1//matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/a0@270000(1ps)#ActiveDriver" 3)}
wvSelectSignal -win $_nWave2 \
           {( "row1//matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/a0@270000(1ps)#ActiveDriver" \
           4 )} 
wvSelectSignal -win $_nWave2 \
           {( "row1" 1 )} {( "row1//matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/a0@270000(1ps)#ActiveDriver" \
           1 2 3 4 )} 
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("row1" 5)}
wvSetPosition -win $_nWave2 \
           {("row1//matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/a0@270000(1ps)#ActiveDriver" 0)}
wvSelectSignal -win $_nWave2 \
           {( "row1//matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/a0@270000(1ps)#ActiveDriver" \
           1 )} 
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 \
           {("row1//matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/a0@270000(1ps)#ActiveDriver" 0)}
srcDeselectAll -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcDeselectAll -win $_nTrace1
srcSelect -signal "a0" -line 215 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("row1" 0)}
wvSetPosition -win $_nWave2 \
           {("row1//matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/a0@270000(1ps)#ActiveDriver" 0)}
wvSetPosition -win $_nWave2 {("row1" 2)}
wvSetPosition -win $_nWave2 {("row1" 3)}
wvSetPosition -win $_nWave2 {("row1" 2)}
wvSetPosition -win $_nWave2 \
           {("row1//matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/a0@270000(1ps)#ActiveDriver" 0)}
wvAddSignal -win $_nWave2 "/matmul_tb/u_matmul/u_matmul_4x4/a0\[7:0\]"
wvSetPosition -win $_nWave2 \
           {("row1//matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/a0@270000(1ps)#ActiveDriver" 0)}
wvSetPosition -win $_nWave2 \
           {("row1//matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/a0@270000(1ps)#ActiveDriver" 1)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "a0_data" -line 215 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "a0_data" -line 215 -pos 1 -win $_nTrace1
srcAction -pos 214 15 2 -win $_nTrace1 -name "a0_data" -ctrlKey off
srcHBSelect "matmul_tb.u_matmul.u_matmul_4x4" -win $_nTrace1
srcSetScope "matmul_tb.u_matmul.u_matmul_4x4" -delim "." -win $_nTrace1
srcHBSelect "matmul_tb.u_matmul.u_matmul_4x4" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcDeselectAll -win $_nTrace1
srcSelect -signal "address_stride_a" -line 27 -pos 1 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G1" 2)}
wvSetPosition -win $_nWave2 {("row1" 0)}
wvSetPosition -win $_nWave2 \
           {("row1//matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/a0@270000(1ps)#ActiveDriver" 0)}
wvSetPosition -win $_nWave2 \
           {("row1//matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/a0@270000(1ps)#ActiveDriver" 1)}
wvSetPosition -win $_nWave2 \
           {("row1//matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/a0@270000(1ps)#ActiveDriver" 0)}
wvAddSignal -win $_nWave2 \
           "/matmul_tb/u_matmul/u_matmul_4x4/address_stride_a\[7:0\]"
wvSetPosition -win $_nWave2 \
           {("row1//matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/a0@270000(1ps)#ActiveDriver" 0)}
wvSetPosition -win $_nWave2 \
           {("row1//matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/a0@270000(1ps)#ActiveDriver" 1)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "address_stride_a" -line 27 -pos 1 -win $_nTrace1
srcAction -pos 26 1 9 -win $_nTrace1 -name "address_stride_a" -ctrlKey off
srcDeselectAll -win $_nTrace1
debExit
