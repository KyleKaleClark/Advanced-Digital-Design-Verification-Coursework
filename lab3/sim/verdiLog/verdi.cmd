verdiSetActWin -dock widgetDock_<Message>
simSetSimulator "-vcssv" -exec "./simv" -args
debImport "-dbdir" "./simv.daidir"
debLoadSimResult /home/a21164_asu/addv/lab3_pleasegod/sim/novas.fsdb
wvCreateWindow
verdiWindowResize -win $_Verdi_1 "182" "23" "1685" "1215"
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
verdiSetActWin -win $_nWave2
wvRestoreSignal -win $_nWave2 \
           "/home/a21164_asu/addv/lab3_pleasegod/sim/strider.rc" \
           -overWriteAutoAlias on -appendSignals on
wvSelectSignal -win $_nWave2 {( "row1" 2 )} 
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWavedebExit
rollDown -win $_nWave2 1
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
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvSelectSignal -win $_nWave2 {( "row1" 12 )} 
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvSelectSignal -win $_nWave2 {( "row1" 11 )} 
wvSetPosition -win $_nWave2 {("row1" 11)}
wvSetPosition -win $_nWave2 {("row1" 10)}
wvSetPosition -win $_nWave2 {("row1" 9)}
wvSetPosition -win $_nWave2 {("row1" 8)}
wvSetPosition -win $_nWave2 {("row1" 9)}
wvSetPosition -win $_nWave2 {("row1" 10)}
wvSetPosition -win $_nWave2 {("row1" 11)}
wvMoveSelected -win $_nWave2
wvSetPosition -win $_nWave2 {("row1" 11)}
wvSelectSignal -win $_nWave2 {( "row1" 5 6 7 8 9 10 11 )} 
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("row2" 2)}
wvSetPosition -win $_nWave2 {("row1" 4)}
wvSelectSignal -win $_nWave2 {( "row1" 1 )} 
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("row1" 4)}
wvSetPosition -win $_nWave2 {("row1" 3)}
wvSelectSignal -win $_nWave2 {( "G1" 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 \
           19 20 )} 
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("row4" 4)}
wvSetPosition -win $_nWave2 {("row1" 3)}
wvSelectSignal -win $_nWave2 {( "G1" 1 )} 
wvSelectSignal -win $_nWave2 {( "row1" 1 2 3 )} 
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("row1" 3)}
wvSetPosition -win $_nWave2 {("row1" 0)}
wvSelectGroup -win $_nWave2 {G1}
wvSetPosition -win $_nWave2 {("row1" 0)}
wvSetPosition -win $_nWave2 {("row1" 0)}
wvSetPosition -win $_nWave2 {("G8" 0)}
wvAddGroup -win $_nWave2 {G8}
wvRenameGroup -win $_nWave2 {G8} {APB Stuff}
wvSelectGroup -win $_nWave2 {APB Stuff}
wvSetPosition -win $_nWave2 {("row1" 4)}
wvSetPosition -win $_nWave2 {("row1" 3)}
wvSetPosition -win $_nWave2 {("row1" 1)}
wvSetPosition -win $_nWave2 {("row1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvMoveSelected -win $_nWave2
wvSetPosition -win $_nWave2 {("G1" 1)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "PSEL" -line 49 -pos 1 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvSetPosition -win $_nWave2 {("APB Stuff" 0)}
wvAddSignal -win $_nWave2 "/matmul_tb/PSEL"
wvSetPosition -win $_nWave2 {("APB Stuff" 0)}
wvSetPosition -win $_nWave2 {("APB Stuff" 1)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "PENABLE" -line 50 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("APB Stuff" 0)}
wvSetPosition -win $_nWave2 {("APB Stuff" 1)}
wvAddSignal -win $_nWave2 "/matmul_tb/PENABLE"
wvSetPosition -win $_nWave2 {("APB Stuff" 1)}
wvSetPosition -win $_nWave2 {("APB Stuff" 2)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "PWRITE" -line 51 -pos 1 -win $_nTrace1
srcAction -pos 50 6 3 -win $_nTrace1 -name "PWRITE" -ctrlKey off
srcBackwardHistory -win $_nTrace1
srcHBSelect "matmul_tb" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "PWRITE" -line 51 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("APB Stuff" 1)}
wvSetPosition -win $_nWave2 {("APB Stuff" 2)}
wvAddSignal -win $_nWave2 "/matmul_tb/PWRITE"
wvSetPosition -win $_nWave2 {("APB Stuff" 2)}
wvSetPosition -win $_nWave2 {("APB Stuff" 3)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "PADDR" -line 52 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("APB Stuff" 1)}
wvSetPosition -win $_nWave2 {("APB Stuff" 2)}
wvSetPosition -win $_nWave2 {("APB Stuff" 3)}
wvSetPosition -win $_nWave2 {("row1" 0)}
wvSetPosition -win $_nWave2 {("APB Stuff" 3)}
wvAddSignal -win $_nWave2 "/matmul_tb/PADDR\[3:0\]"
wvSetPosition -win $_nWave2 {("APB Stuff" 3)}
wvSetPosition -win $_nWave2 {("APB Stuff" 4)}
wvSelectSignal -win $_nWave2 {( "APB Stuff" 3 )} 
verdiSetActWin -win $_nWave2
wvSelectSignal -win $_nWave2 {( "APB Stuff" 4 )} 
srcDeselectAll -win $_nTrace1
srcSelect -signal "PWDATA" -line 53 -pos 1 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvSetPosition -win $_nWave2 {("APB Stuff" 1)}
wvSetPosition -win $_nWave2 {("APB Stuff" 4)}
wvSetPosition -win $_nWave2 {("row1" 0)}
wvSetPosition -win $_nWave2 {("APB Stuff" 4)}
wvAddSignal -win $_nWave2 "/matmul_tb/PWDATA\[15:0\]"
wvSetPosition -win $_nWave2 {("APB Stuff" 4)}
wvSetPosition -win $_nWave2 {("APB Stuff" 5)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "PRDATA" -line 54 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("APB Stuff" 1)}
wvSetPosition -win $_nWave2 {("APB Stuff" 5)}
wvAddSignal -win $_nWave2 "/matmul_tb/PRDATA\[15:0\]"
wvSetPosition -win $_nWave2 {("APB Stuff" 5)}
wvSetPosition -win $_nWave2 {("APB Stuff" 6)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "PREADY" -line 55 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("APB Stuff" 3)}
wvSetPosition -win $_nWave2 {("APB Stuff" 1)}
wvSetPosition -win $_nWave2 {("APB Stuff" 5)}
wvSetPosition -win $_nWave2 {("APB Stuff" 6)}
wvSetPosition -win $_nWave2 {("row1" 0)}
wvSetPosition -win $_nWave2 {("APB Stuff" 6)}
wvAddSignal -win $_nWave2 "/matmul_tb/PREADY"
wvSetPosition -win $_nWave2 {("APB Stuff" 6)}
wvSetPosition -win $_nWave2 {("APB Stuff" 7)}
wvSelectSignal -win $_nWave2 {( "APB Stuff" 7 )} 
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("row1" 0)}
wvSetPosition -win $_nWave2 {("APB Stuff" 6)}
verdiSetActWin -win $_nWave2
srcDeselectAll -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
verdiSetActWin -win $_nWave2
srcHBSelect "FPAddSub_NormalizeShift1" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "matmul_tb" -win $_nTrace1
srcHBSelect "matmul_tb.u_matmul" -win $_nTrace1
srcSetScope "matmul_tb.u_matmul" -delim "." -win $_nTrace1
srcHBSelect "matmul_tb.u_matmul" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "state" -line 125 -pos 1 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("APB Stuff" 0)}
wvAddSignal -win $_nWave2 "/matmul_tb/u_matmul/state\[3:0\]"
wvSetPosition -win $_nWave2 {("APB Stuff" 0)}
wvSetPosition -win $_nWave2 {("APB Stuff" 1)}
verdiSetActWin -win $_nWave2
srcDeselectAll -win $_nTrace1
srcSelect -signal "address_mat_a" -line 226 -pos 1 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvSetPosition -win $_nWave2 {("APB Stuff" 3)}
wvSetPosition -win $_nWave2 {("APB Stuff" 6)}
wvSetPosition -win $_nWave2 {("APB Stuff" 7)}
wvAddSignal -win $_nWave2 "/matmul_tb/u_matmul/address_mat_a\[9:0\]"
wvSetPosition -win $_nWave2 {("APB Stuff" 7)}
wvSetPosition -win $_nWave2 {("APB Stuff" 8)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "address_mat_b" -line 227 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("APB Stuff" 2)}
wvSetPosition -win $_nWave2 {("APB Stuff" 4)}
wvSetPosition -win $_nWave2 {("APB Stuff" 6)}
wvSetPosition -win $_nWave2 {("APB Stuff" 7)}
wvSetPosition -win $_nWave2 {("APB Stuff" 8)}
wvAddSignal -win $_nWave2 "/matmul_tb/u_matmul/address_mat_b\[9:0\]"
wvSetPosition -win $_nWave2 {("APB Stuff" 8)}
wvSetPosition -win $_nWave2 {("APB Stuff" 9)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "address_mat_c" -line 228 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("APB Stuff" 6)}
wvSetPosition -win $_nWave2 {("row1" 0)}
wvSetPosition -win $_nWave2 {("APB Stuff" 9)}
wvAddSignal -win $_nWave2 "/matmul_tb/u_matmul/address_mat_c\[9:0\]"
wvSetPosition -win $_nWave2 {("APB Stuff" 9)}
wvSetPosition -win $_nWave2 {("APB Stuff" 10)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "address_stride_a" -line 229 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("APB Stuff" 5)}
wvSetPosition -win $_nWave2 {("APB Stuff" 6)}
wvSetPosition -win $_nWave2 {("APB Stuff" 9)}
wvSetPosition -win $_nWave2 {("APB Stuff" 10)}
wvAddSignal -win $_nWave2 "/matmul_tb/u_matmul/address_stride_a\[7:0\]"
wvSetPosition -win $_nWave2 {("APB Stuff" 10)}
wvSetPosition -win $_nWave2 {("APB Stuff" 11)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "address_stride_b" -line 230 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("APB Stuff" 5)}
wvSetPosition -win $_nWave2 {("APB Stuff" 6)}
wvSetPosition -win $_nWave2 {("APB Stuff" 10)}
wvSetPosition -win $_nWave2 {("APB Stuff" 11)}
wvAddSignal -win $_nWave2 "/matmul_tb/u_matmul/address_stride_b\[7:0\]"
wvSetPosition -win $_nWave2 {("APB Stuff" 11)}
wvSetPosition -win $_nWave2 {("APB Stuff" 12)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "address_stride_c" -line 231 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("APB Stuff" 0)}
wvSetPosition -win $_nWave2 {("APB Stuff" 6)}
wvSetPosition -win $_nWave2 {("APB Stuff" 12)}
wvAddSignal -win $_nWave2 "/matmul_tb/u_matmul/address_stride_c\[7:0\]"
wvSetPosition -win $_nWave2 {("APB Stuff" 12)}
wvSetPosition -win $_nWave2 {("APB Stuff" 13)}
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
verdiSetActWin -win $_nWave2
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
srcHBSelect "matmul_tb.u_matmul.u_matmul_4x4" -win $_nTrace1
srcSetScope "matmul_tb.u_matmul.u_matmul_4x4" -delim "." -win $_nTrace1
srcHBSelect "matmul_tb.u_matmul.u_matmul_4x4" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "matmul_tb.u_matmul.u_matmul_4x4.u_systolic_pe_matrix" -win $_nTrace1
srcSetScope "matmul_tb.u_matmul.u_matmul_4x4.u_systolic_pe_matrix" -delim "." \
           -win $_nTrace1
srcHBSelect "matmul_tb.u_matmul.u_matmul_4x4.u_systolic_pe_matrix" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "all_flags" -line 779 -pos 1 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvSetPosition -win $_nWave2 {("APB Stuff" 1)}
wvSetPosition -win $_nWave2 {("APB Stuff" 6)}
wvSetPosition -win $_nWave2 {("row4" 1)}
wvSetPosition -win $_nWave2 {("row4" 2)}
wvSetPosition -win $_nWave2 {("row4" 3)}
wvSetPosition -win $_nWave2 {("row4" 4)}
wvSetPosition -win $_nWave2 {("G7" 0)}
wvAddSignal -win $_nWave2 \
           "/matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/all_flags\[4:0\]"
wvSetPosition -win $_nWave2 {("G7" 0)}
wvSetPosition -win $_nWave2 {("G7" 1)}
wvSetPosition -win $_nWave2 {("G7" 1)}
verdiSetActWin -win $_nWave2
wvScrollDown -win $_nWave2 1
wvSelectGroup -win $_nWave2 {G7}
wvRenameGroup -win $_nWave2 {G7} {flags}
wvSelectSignal -win $_nWave2 {( "flags" 1 )} 
wvShowOneTraceSignals -win $_nWave2 -signal \
           "/matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/all_flags\[4:0\]" \
           -driver
wvSelectGroup -win $_nWave2 \
           {flags//matmul_tb/u_matmul/u_matmul_4x4/u_systolic_pe_matrix/all_flags@10000(1ps)#ActiveDriver}
wvScrollUp -win $_nWave2 17
wvScrollUp -win $_nWave2 3
verdiWindowResize -win $_Verdi_1 "489" "19" "1685" "1371"
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvSetCursor -win $_nWave2 764188.074889 -snap {("APB Stuff" 12)}
wvSelectSignal -win $_nWave2 {( "row4" 4 )} 
verdiWindowResize -win $_Verdi_1 "133" "19" "1192" "1371"
verdiWindowResize -win $_Verdi_1 "133" "19" "1122" "1371"
wvZoomOut -win $_nWave2
verdiWindowResize -win $_Verdi_1 "819" "19" "436" "1371"
verdiWindowResize -win $_Verdi_1 "4" "19" "1251" "1371"
srcHBSelect "FPAddSub_NormalizeShift1" -win $_nTrace1
srcHBSelect "matmul_tb" -win $_nTrace1
srcSetScope "matmul_tb" -delim "." -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "matmul_tb" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "start" -line 46 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "done" -line 47 -pos 1 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvSetPosition -win $_nWave2 {("APB Stuff" 6)}
wvSetPosition -win $_nWave2 {("APB Stuff" 8)}
wvSetPosition -win $_nWave2 {("APB Stuff" 9)}
wvSetPosition -win $_nWave2 {("APB Stuff" 8)}
wvSetPosition -win $_nWave2 {("APB Stuff" 7)}
wvSetPosition -win $_nWave2 {("APB Stuff" 6)}
wvSetPosition -win $_nWave2 {("APB Stuff" 5)}
wvSetPosition -win $_nWave2 {("APB Stuff" 4)}
wvSetPosition -win $_nWave2 {("APB Stuff" 3)}
wvSetPosition -win $_nWave2 {("APB Stuff" 4)}
wvAddSignal -win $_nWave2 "/matmul_tb/done"
wvSetPosition -win $_nWave2 {("APB Stuff" 4)}
wvSetPosition -win $_nWave2 {("APB Stuff" 5)}
wvSelectSignal -win $_nWave2 {( "APB Stuff" 5 )} 
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("APB Stuff" 5)}
wvSetPosition -win $_nWave2 {("APB Stuff" 4)}
verdiSetActWin -win $_nWave2
srcHBSelect "matmul_tb.u_matmul" -win $_nTrace1
srcSetScope "matmul_tb.u_matmul" -delim "." -win $_nTrace1
srcHBSelect "matmul_tb.u_matmul" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcDeselectAll -win $_nTrace1
srcSelect -signal "done_mat_mul" -line 173 -pos 1 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvSetPosition -win $_nWave2 {("APB Stuff" 6)}
wvSetPosition -win $_nWave2 {("APB Stuff" 1)}
wvSetPosition -win $_nWave2 {("APB Stuff" 2)}
wvSetPosition -win $_nWave2 {("APB Stuff" 3)}
wvSetPosition -win $_nWave2 {("APB Stuff" 4)}
wvSetPosition -win $_nWave2 {("APB Stuff" 3)}
wvSetPosition -win $_nWave2 {("APB Stuff" 2)}
wvSetPosition -win $_nWave2 {("APB Stuff" 1)}
wvAddSignal -win $_nWave2 "/matmul_tb/u_matmul/done_mat_mul"
wvSetPosition -win $_nWave2 {("APB Stuff" 1)}
wvSetPosition -win $_nWave2 {("APB Stuff" 2)}
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "start_mat_mul" -line 173 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("APB Stuff" 6)}
wvSetPosition -win $_nWave2 {("APB Stuff" 2)}
wvAddSignal -win $_nWave2 "/matmul_tb/u_matmul/start_mat_mul"
wvSetPosition -win $_nWave2 {("APB Stuff" 2)}
wvSetPosition -win $_nWave2 {("APB Stuff" 3)}
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
verdiSetActWin -win $_nWave2
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 0
verdiWindowResize -win $_Verdi_1 "4" "19" "1251" "1237"
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvSaveSignal -win $_nWave2 "/home/a21164_asu/addv/lab3_pleasegod/sim/allvals.rc"
debExit
