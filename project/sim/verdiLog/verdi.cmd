verdiSetActWin -dock widgetDock_<Message>
simSetSimulator "-vcssv" -exec "./simv" -args
debImport "-dbdir" "./simv.daidir"
debLoadSimResult /home/a21164_asu/addv/project/sim/novas.fsdb
wvCreateWindow
verdiWindowResize -win $_Verdi_1 -10 "23" "994" "1187"
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -win $_nTrace1 -range {197 206 1 1 25 1}
srcDeselectAll -win $_nTrace1
verdiSetActWin -win $_nWave2
wvRestoreSignal -win $_nWave2 "/home/a21164_asu/addv/lab4/sim/fifo_dpi.rc" \
           -overWriteAutoAlias on -appendSignals on
verdiWindowResize -win $_Verdi_1 -10 "23" "1494" "1187"
srcDeselectAll -win $_nTrace1
srcSelect -win $_nTrace1 -signal "rd_if.rdata" -line 218 -pos 1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("fifo_q" 0)}
wvSetPosition -win $_nWave2 {("G1" 2)}
wvAddSignal -win $_nWave2 "/fifo_tb/rd_if/rdata\[7:0\]"
wvSetPosition -win $_nWave2 {("G1" 2)}
wvSetPosition -win $_nWave2 {("G1" 3)}
srcDeselectAll -win $_nTrace1
srcSelect -win $_nTrace1 -signal "wr_if.wdata" -line 211 -pos 1
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 3)}
wvSetPosition -win $_nWave2 {("G1" 2)}
wvAddSignal -win $_nWave2 "/fifo_tb/wr_if/wdata\[7:0\]"
wvSetPosition -win $_nWave2 {("G1" 2)}
wvSetPosition -win $_nWave2 {("G1" 3)}
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -win $_nTrace1 -range {213 222 1 1 1 1}
srcDeselectAll -win $_nTrace1
verdiSetActWin -win $_nWave2
srcDeselectAll -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcHBSelect "fifo_tb.f1" -win $_nTrace1
srcSetScope "fifo_tb.f1" -delim "." -win $_nTrace1
srcHBSelect "fifo_tb.f1" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "fifo_tb.f1" -win $_nTrace1
srcSetScope "fifo_tb.f1" -delim "." -win $_nTrace1
srcHBSelect "fifo_tb.f1" -win $_nTrace1
srcHBSelect "fifo_tb" -win $_nTrace1
srcSetScope "fifo_tb" -delim "." -win $_nTrace1
srcHBSelect "fifo_tb" -win $_nTrace1
verdiSetActWin -win $_nWave2
srcHBSelect "fifo_tb.f1" -win $_nTrace1
srcSetScope "fifo_tb.f1" -delim "." -win $_nTrace1
srcHBSelect "fifo_tb.f1" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcDeselectAll -win $_nTrace1
srcSelect -inst "rptr_empty" -line 27 -pos 2 -win $_nTrace1
srcAction -pos 26 8 5 -win $_nTrace1 -name "rptr_empty" -ctrlKey off
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcBackwardHistory -win $_nTrace1
srcHBSelect "fifo_tb.f1" -win $_nTrace1
