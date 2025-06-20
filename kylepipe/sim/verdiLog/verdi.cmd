verdiSetActWin -dock widgetDock_<Message>
simSetSimulator "-vcssv" -exec "./simv" -args
debImport "-dbdir" "./simv.daidir"
debLoadSimResult /home/a21164_asu/addv/kylepipe/sim/novas.fsdb
wvCreateWindow
verdiWindowResize -win $_Verdi_1 "1356" "124" "1182" "1102"
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
debExit
