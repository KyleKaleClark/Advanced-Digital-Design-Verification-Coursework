verdiSetActWin -dock widgetDock_<Message>
simSetSimulator "-vcssv" -exec "./simv" -args
debImport "-dbdir" "./simv.daidir"
debLoadSimResult /home/a21164_asu/ADDV_FUDGE/lab2_singlecycle/sim/novas.fsdb
wvCreateWindow
verdiWindowResize -win $_Verdi_1 "456" "43" "1178" "1133"
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
verdiWindowResize -win $_Verdi_1 "456" "43" "1992" "1142"
verdiWindowResize -win $_Verdi_1 "115" "43" "2333" "1165"
