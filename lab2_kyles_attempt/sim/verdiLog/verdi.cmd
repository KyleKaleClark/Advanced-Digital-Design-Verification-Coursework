simSetSimulator "-vcssv" -exec "./simv" -args
debImport "-dbdir" "./simv.daidir"
debLoadSimResult /home/a21164_asu/ADDV_FUDGE/lab2_singlecycle/sim/novas.fsdb
wvCreateWindow
verdiWindowResize -win $_Verdi_1 "26" "53" "1236" "1133"
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
