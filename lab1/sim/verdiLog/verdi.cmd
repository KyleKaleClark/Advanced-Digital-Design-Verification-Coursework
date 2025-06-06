simSetSimulator "-vcssv" -exec "./simv" -args
debImport "-dbdir" "./simv.daidir"
debLoadSimResult /home/a21164_asu/addv/lab1/sim/novas.fsdb
wvCreateWindow
verdiWindowResize -win $_Verdi_1 "0" "0" "2289" "1021"
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "wdata" -line 4 -pos 1 -win $_nTrace1
wvAddSignal -win $_nWave2 "/fifo_tb/wdata\[7:0\]"
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G1" 1)}
debExit
