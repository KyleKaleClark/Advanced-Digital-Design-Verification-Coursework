simSetSimulator "-vcssv" -exec "./simv" -args
debImport "-dbdir" "./simv.daidir"
debLoadSimResult /home/a21164_asu/addv/lab2/sim/novas.fsdb
wvCreateWindow
verdiWindowResize -win $_Verdi_1 "820" "281" "900" "700"
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
