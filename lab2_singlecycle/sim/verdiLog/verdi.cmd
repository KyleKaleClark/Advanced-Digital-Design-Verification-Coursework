verdiSetActWin -dock widgetDock_<Message>
simSetSimulator "-vcssv" -exec "./simv" -args
debImport "-dbdir" "./simv.daidir"
debLoadSimResult /home/a21164_asu/addv/lab2_singlecycle/sim/novas.fsdb
wvCreateWindow
verdiWindowResize -win $_Verdi_1 "1291" "23" "1182" "1096"
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
debExit
dowResize -win $_Verdi_1 "1285" "52" "1182" "1143"
srcDeselectAll -win $_nTrace1
srcSelect -signal "writedata" -line 11 -pos 1 -win $_nTrace1
wvAddSignal -win $_nWave2 "/MIPS_Testbench/writedata\[31:0\]"
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G1" 1)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "dataadr" -line 11 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvAddSignal -win $_nWave2 "/MIPS_Testbench/dataadr\[31:0\]"
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G1" 2)}
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
srcDeselectAll -win $_nTrace1
srcSelect -signal "memwrite" -line 12 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G1" 0)}
wvAddSignal -win $_nWave2 "/MIPS_Testbench/memwrite"
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetCursor -win $_nWave2 14.868020 -snap {("G1" 1)}
verdiSetActWin -win $_nWave2
srcHBSelect "MIPS_Testbench.dut" -win $_nTrace1
srcSetScope "MIPS_Testbench.dut" -delim "." -win $_nTrace1
srcHBSelect "MIPS_Testbench.dut" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcDeselectAll -win $_nTrace1
srcSelect -signal "instr" -line 18 -pos 1 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 2)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G1" 3)}
wvAddSignal -win $_nWave2 "/MIPS_Testbench/dut/instr\[31:0\]"
wvSetPosition -win $_nWave2 {("G1" 3)}
wvSetPosition -win $_nWave2 {("G1" 4)}
srcHBSelect "MIPS_Testbench.dut.mips" -win $_nTrace1
srcSetScope "MIPS_Testbench.dut.mips" -delim "." -win $_nTrace1
srcHBSelect "MIPS_Testbench.dut.mips" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "MIPS_Testbench.dut.mips.dp" -win $_nTrace1
srcSetScope "MIPS_Testbench.dut.mips.dp" -delim "." -win $_nTrace1
srcHBSelect "MIPS_Testbench.dut.mips.dp" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "srca" -line 59 -pos 1 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvSetPosition -win $_nWave2 {("G1" 2)}
wvSetPosition -win $_nWave2 {("G1" 3)}
wvSetPosition -win $_nWave2 {("G1" 4)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvAddSignal -win $_nWave2 "/MIPS_Testbench/dut/mips/dp/srca\[31:0\]"
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G2" 1)}
wvSetPosition -win $_nWave2 {("G2" 1)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "srcb" -line 59 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G3" 0)}
wvSetPosition -win $_nWave2 {("G2" 1)}
wvAddSignal -win $_nWave2 "/MIPS_Testbench/dut/mips/dp/srcb\[31:0\]"
wvSetPosition -win $_nWave2 {("G2" 1)}
wvSetPosition -win $_nWave2 {("G2" 2)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "alucontrol" -line 59 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G2" 1)}
wvSetPosition -win $_nWave2 {("G2" 2)}
wvSetPosition -win $_nWave2 {("G2" 1)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvAddSignal -win $_nWave2 "/MIPS_Testbench/dut/mips/dp/alucontrol\[2:0\]"
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G2" 1)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "alusrc" -line 57 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 3)}
wvSetPosition -win $_nWave2 {("G2" 2)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G2" 1)}
wvSetPosition -win $_nWave2 {("G2" 2)}
wvAddSignal -win $_nWave2 "/MIPS_Testbench/dut/mips/dp/alusrc"
wvSetPosition -win $_nWave2 {("G2" 2)}
wvSetPosition -win $_nWave2 {("G2" 3)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "writedata" -line 57 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G2" 2)}
wvSetPosition -win $_nWave2 {("G2" 3)}
wvAddSignal -win $_nWave2 "/MIPS_Testbench/dut/mips/dp/writedata\[31:0\]"
wvSetPosition -win $_nWave2 {("G2" 3)}
wvSetPosition -win $_nWave2 {("G2" 4)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "signimm" -line 57 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G1" 4)}
wvSetPosition -win $_nWave2 {("G2" 2)}
wvSetPosition -win $_nWave2 {("G2" 5)}
wvSetPosition -win $_nWave2 {("G2" 4)}
wvAddSignal -win $_nWave2 "/MIPS_Testbench/dut/mips/dp/signimm\[31:0\]"
wvSetPosition -win $_nWave2 {("G2" 4)}
wvSetPosition -win $_nWave2 {("G2" 5)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "srca" -line 59 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G2" 1)}
wvSetPosition -win $_nWave2 {("G2" 3)}
wvSetPosition -win $_nWave2 {("G2" 4)}
wvSetPosition -win $_nWave2 {("G2" 5)}
wvSetPosition -win $_nWave2 {("G2" 6)}
wvSetPosition -win $_nWave2 {("G3" 0)}
wvAddSignal -win $_nWave2 "/MIPS_Testbench/dut/mips/dp/srca\[31:0\]"
wvSetPosition -win $_nWave2 {("G3" 0)}
wvSetPosition -win $_nWave2 {("G3" 1)}
wvSetPosition -win $_nWave2 {("G3" 1)}
wvSelectSignal -win $_nWave2 {( "G1" 2 )} 
verdiSetActWin -win $_nWave2
srcDeselectAll -win $_nTrace1
srcSelect -signal "aluout" -line 59 -pos 1 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcDeselectAll -win $_nTrace1
srcSelect -signal "writedata" -line 57 -pos 1 -win $_nTrace1
srcActiveTrace "MIPS_Testbench.dut.mips.dp.writedata\[31:0\]" -win $_nTrace1
srcBackwardHistory -win $_nTrace1
srcHBSelect "MIPS_Testbench.dut.mips.dp" -win $_nTrace1
srcActiveTrace "MIPS_Testbench.dut.mips.dp.writedata\[31:0\]" -win $_nTrace1
srcBackwardHistory -win $_nTrace1
srcHBSelect "MIPS_Testbench.dut.mips.dp" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "logicwrite" -line 51 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G2" 5)}
wvSetPosition -win $_nWave2 {("G3" 1)}
wvAddSignal -win $_nWave2 "/MIPS_Testbench/dut/mips/dp/logicwrite"
wvSetPosition -win $_nWave2 {("G3" 1)}
wvSetPosition -win $_nWave2 {("G3" 2)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "writedata" -line 51 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G3" 1)}
wvSetPosition -win $_nWave2 {("G2" 5)}
wvSetPosition -win $_nWave2 {("G3" 2)}
wvAddSignal -win $_nWave2 "/MIPS_Testbench/dut/mips/dp/writedata\[31:0\]"
wvSetPosition -win $_nWave2 {("G3" 2)}
wvSetPosition -win $_nWave2 {("G3" 3)}
wvSetCursor -win $_nWave2 4.973096 -snap {("G3" 3)}
verdiSetActWin -win $_nWave2
srcDeselectAll -win $_nTrace1
srcSelect -signal "instr\[20:16\]" -line 51 -pos 1 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvSetPosition -win $_nWave2 {("G2" 5)}
wvSetPosition -win $_nWave2 {("G3" 0)}
wvSetPosition -win $_nWave2 {("G3" 1)}
wvSetPosition -win $_nWave2 {("G3" 2)}
wvSetPosition -win $_nWave2 {("G3" 3)}
wvSetPosition -win $_nWave2 {("G4" 0)}
wvSetPosition -win $_nWave2 {("G3" 3)}
wvSetPosition -win $_nWave2 {("G3" 2)}
wvSetPosition -win $_nWave2 {("G3" 3)}
wvAddSignal -win $_nWave2 "/MIPS_Testbench/dut/mips/dp/instr\[20:16\]"
wvSetPosition -win $_nWave2 {("G3" 3)}
wvSetPosition -win $_nWave2 {("G3" 4)}
srcDeselectAll -win $_nTrace1
srcSelect -inst "rf" -line 51 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -inst "rf" -line 51 -pos 1 -win $_nTrace1
srcAction -pos 50 3 0 -win $_nTrace1 -name "rf" -ctrlKey off
srcBackwardHistory -win $_nTrace1
srcHBSelect "MIPS_Testbench.dut.mips.dp" -win $_nTrace1
verdiSetActWin -win $_nWave2
verdiWindowResize -win $_Verdi_1 "1280" "91" "1222" "1145"
wvSetPosition -win $_nWave2 {("G3" 0)}
wvCollapseGroup -win $_nWave2 "G3"
wvCollapseGroup -win $_nWave2 "G2"
srcDeselectAll -win $_nTrace1
srcSelect -signal "instr\[20:16\]" -line 51 -pos 1 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G1" 3)}
wvSetPosition -win $_nWave2 {("G2" 5)}
wvSetPosition -win $_nWave2 {("G4" 0)}
wvAddSignal -win $_nWave2 "/MIPS_Testbench/dut/mips/dp/instr\[20:16\]"
wvSetPosition -win $_nWave2 {("G4" 0)}
wvSetPosition -win $_nWave2 {("G4" 1)}
wvSetPosition -win $_nWave2 {("G4" 1)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "writedata" -line 51 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 3)}
wvSetPosition -win $_nWave2 {("G2" 5)}
wvSetPosition -win $_nWave2 {("G5" 0)}
wvSetPosition -win $_nWave2 {("G4" 1)}
wvAddSignal -win $_nWave2 "/MIPS_Testbench/dut/mips/dp/writedata\[31:0\]"
wvSetPosition -win $_nWave2 {("G4" 1)}
wvSetPosition -win $_nWave2 {("G4" 2)}
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "clk" -line 51 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G1" 0)}
wvAddSignal -win $_nWave2 "/MIPS_Testbench/dut/mips/dp/clk"
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "logicwrite" -line 51 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G3" 0)}
wvSetPosition -win $_nWave2 {("G4" 0)}
wvSetPosition -win $_nWave2 {("G4" 1)}
wvSetPosition -win $_nWave2 {("G4" 2)}
wvSetPosition -win $_nWave2 {("G4" 1)}
wvSetPosition -win $_nWave2 {("G4" 0)}
wvAddSignal -win $_nWave2 "/MIPS_Testbench/dut/mips/dp/logicwrite"
wvSetPosition -win $_nWave2 {("G4" 0)}
wvSetPosition -win $_nWave2 {("G4" 1)}
wvSelectSignal -win $_nWave2 {( "G1" 1 )} 
verdiSetActWin -win $_nWave2
wvSelectSignal -win $_nWave2 {( "G4" 1 )} 
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("G4" 1)}
wvSetPosition -win $_nWave2 {("G4" 0)}
wvSelectSignal -win $_nWave2 {( "G4" 1 )} 
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("G4" 0)}
wvSelectSignal -win $_nWave2 {( "G4" 1 )} 
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("G4" 0)}
wvSelectSignal -win $_nWave2 {( "G1" 5 )} 
wvSetPosition -win $_nWave2 {("G1" 5)}
wvSetPosition -win $_nWave2 {("G1" 4)}
wvSetPosition -win $_nWave2 {("G1" 3)}
wvSetPosition -win $_nWave2 {("G1" 2)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G1" 0)}
wvMoveSelected -win $_nWave2
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetCursor -win $_nWave2 14.881643 -snap {("G1" 2)}
wvSelectSignal -win $_nWave2 {( "G1" 5 )} 
wvSelectSignal -win $_nWave2 {( "G1" 4 )} 
wvSetPosition -win $_nWave2 {("G1" 4)}
wvSetPosition -win $_nWave2 {("G1" 5)}
wvMoveSelected -win $_nWave2
wvSetPosition -win $_nWave2 {("G1" 5)}
wvSelectSignal -win $_nWave2 {( "G1" 2 )} 
wvSetPosition -win $_nWave2 {("G1" 2)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G1" 0)}
wvMoveSelected -win $_nWave2
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
verdiWindowResize -win $_Verdi_1 "1280" "79" "1222" "1114"
srcDeselectAll -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcHBSelect "MIPS_Testbench.dut.dmem" -win $_nTrace1
srcSetScope "MIPS_Testbench.dut.dmem" -delim "." -win $_nTrace1
srcHBSelect "MIPS_Testbench.dut.dmem" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcDeselectAll -win $_nTrace1
srcSelect -signal "we" -line 52 -pos 1 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvSetPosition -win $_nWave2 {("G1" 2)}
wvSetPosition -win $_nWave2 {("G1" 3)}
wvSetPosition -win $_nWave2 {("G1" 4)}
wvSetPosition -win $_nWave2 {("G1" 5)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvAddSignal -win $_nWave2 "/MIPS_Testbench/dut/dmem/we"
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G2" 1)}
wvSelectGroup -win $_nWave2 {G2}
verdiSetActWin -win $_nWave2
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("G3" 1)}
wvSetPosition -win $_nWave2 {("G1" 5)}
wvSelectGroup -win $_nWave2 {G3}
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("G1" 5)}
wvSelectGroup -win $_nWave2 {G4}
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("G1" 5)}
wvSelectGroup -win $_nWave2 {G5}
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("G1" 5)}
wvSetPosition -win $_nWave2 {("G1" 5)}
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 3)}
wvSetPosition -win $_nWave2 {("G1" 4)}
wvSetPosition -win $_nWave2 {("G1" 5)}
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvSetPosition -win $_nWave2 {("G2" 0)}
wvAddSignal -win $_nWave2 "/MIPS_Testbench/dut/dmem/we"
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G2" 1)}
wvSetPosition -win $_nWave2 {("G2" 1)}
wvSelectSignal -win $_nWave2 {( "G1" 5 )} 
wvSetPosition -win $_nWave2 {("G1" 5)}
wvExpandBus -win $_nWave2
wvSetPosition -win $_nWave2 {("G2" 1)}
verdiSetActWin -win $_nWave2
wvScrollUp -win $_nWave2 8
wvScrollUp -win $_nWave2 10
wvSelectSignal -win $_nWave2 {( "G1" 5 )} 
wvSetPosition -win $_nWave2 {("G1" 5)}
wvCollapseBus -win $_nWave2
wvSetPosition -win $_nWave2 {("G1" 5)}
wvSetPosition -win $_nWave2 {("G2" 1)}
wvSelectGroup -win $_nWave2 {G2}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSelectGroup -win $_nWave2 {G2}
wvRenameGroup -win $_nWave2 {G2} {dmem}
srcDeselectAll -win $_nTrace1
srcSelect -signal "a" -line 53 -pos 1 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G1" 2)}
wvSetPosition -win $_nWave2 {("G1" 3)}
wvSetPosition -win $_nWave2 {("G1" 4)}
wvSetPosition -win $_nWave2 {("G1" 5)}
wvSetPosition -win $_nWave2 {("dmem" 0)}
wvSetPosition -win $_nWave2 {("dmem" 1)}
wvSetPosition -win $_nWave2 {("G3" 0)}
wvAddSignal -win $_nWave2 "/MIPS_Testbench/dut/dmem/a\[31:0\]"
wvSetPosition -win $_nWave2 {("G3" 0)}
wvSetPosition -win $_nWave2 {("G3" 1)}
wvSetPosition -win $_nWave2 {("G3" 1)}
wvSetPosition -win $_nWave2 {("G3" 0)}
wvSetPosition -win $_nWave2 {("dmem" 1)}
verdiSetActWin -win $_nWave2
wvMoveSelected -win $_nWave2
wvSetPosition -win $_nWave2 {("dmem" 1)}
wvSetPosition -win $_nWave2 {("dmem" 2)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "wd" -line 53 -pos 1 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G1" 3)}
wvSetPosition -win $_nWave2 {("G1" 5)}
wvSetPosition -win $_nWave2 {("dmem" 1)}
wvSetPosition -win $_nWave2 {("dmem" 2)}
wvSetPosition -win $_nWave2 {("G3" 0)}
wvSetPosition -win $_nWave2 {("dmem" 2)}
wvAddSignal -win $_nWave2 "/MIPS_Testbench/dut/dmem/wd\[31:0\]"
wvSetPosition -win $_nWave2 {("dmem" 2)}
wvSetPosition -win $_nWave2 {("dmem" 3)}
srcBackwardHistory -win $_nTrace1
srcHBSelect "MIPS_Testbench.dut.mips.dp" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcAction -pos 65 2 4 -win $_nTrace1 -name "logicfile" -ctrlKey off
srcDeselectAll -win $_nTrace1
srcSelect -signal "rd2" -line 71 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("dmem" 2)}
wvSetPosition -win $_nWave2 {("dmem" 3)}
wvSetPosition -win $_nWave2 {("G3" 0)}
wvSetPosition -win $_nWave2 {("G4" 0)}
wvSetPosition -win $_nWave2 {("G3" 0)}
wvSetPosition -win $_nWave2 {("G4" 0)}
wvSetPosition -win $_nWave2 {("G3" 0)}
wvSetPosition -win $_nWave2 {("G4" 0)}
wvAddSignal -win $_nWave2 "/MIPS_Testbench/dut/mips/dp/rf/rd2\[31:0\]"
wvSetPosition -win $_nWave2 {("G4" 0)}
wvSetPosition -win $_nWave2 {("G4" 1)}
wvSetPosition -win $_nWave2 {("G4" 1)}
srcBackwardHistory -win $_nTrace1
srcHBSelect "MIPS_Testbench.dut.mips.dp" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -inst "rf" -line 51 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("dmem" 3)}
wvSetPosition -win $_nWave2 {("G4" 1)}
wvSetPosition -win $_nWave2 {("G5" 0)}
wvSetPosition -win $_nWave2 {("G4" 1)}
wvSetPosition -win $_nWave2 {("G4" 0)}
wvAddSignal -win $_nWave2 "/MIPS_Testbench/dut/mips/dp/clk" \
           "/MIPS_Testbench/dut/mips/dp/logicwrite" \
           "/MIPS_Testbench/dut/mips/dp/instr\[25:21\]" \
           "/MIPS_Testbench/dut/mips/dp/instr\[20:16\]" \
           "/MIPS_Testbench/dut/mips/dp/writereg\[4:0\]" \
           "/MIPS_Testbench/dut/mips/dp/result\[31:0\]" \
           "/MIPS_Testbench/dut/mips/dp/srca\[31:0\]" \
           "/MIPS_Testbench/dut/mips/dp/writedata\[31:0\]" \
           "/MIPS_Testbench/dut/mips/dp/wb_dat\[31:0\]"
wvSetPosition -win $_nWave2 {("G4" 0)}
wvSetPosition -win $_nWave2 {("G4" 9)}
verdiSetActWin -win $_nWave2
wvScrollDown -win $_nWave2 2
wvSelectSignal -win $_nWave2 {( "G4" 3 )} 
wvSelectSignal -win $_nWave2 {( "G4" 4 )} 
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvSelectSignal -win $_nWave2 {( "G4" 1 )} 
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("G4" 9)}
wvSetPosition -win $_nWave2 {("G4" 8)}
wvSetCursor -win $_nWave2 14.930435 -snap {("G4" 1)}
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
srcDeselectAll -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcDeselectAll -win $_nTrace1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
verdiSetActWin -win $_nWave2
wvScrollDown -win $_nWave2 0
wvSelectSignal -win $_nWave2 {( "G4" 7 )} 
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("G4" 8)}
wvSetPosition -win $_nWave2 {("G4" 7)}
wvSetCursor -win $_nWave2 0.439130 -snap {("G4" 1)}
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
srcDeselectAll -win $_nTrace1
srcSelect -inst "rf" -line 51 -pos 1 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvSetPosition -win $_nWave2 {("dmem" 0)}
wvSetPosition -win $_nWave2 {("G4" 0)}
wvSetPosition -win $_nWave2 {("G4" 3)}
wvSetPosition -win $_nWave2 {("G4" 4)}
wvSetPosition -win $_nWave2 {("G4" 5)}
wvSetPosition -win $_nWave2 {("G4" 8)}
wvSetPosition -win $_nWave2 {("G5" 0)}
wvAddSignal -win $_nWave2 "/MIPS_Testbench/dut/mips/dp/clk" \
           "/MIPS_Testbench/dut/mips/dp/logicwrite" \
           "/MIPS_Testbench/dut/mips/dp/instr\[25:21\]" \
           "/MIPS_Testbench/dut/mips/dp/instr\[20:16\]" \
           "/MIPS_Testbench/dut/mips/dp/writereg\[4:0\]" \
           "/MIPS_Testbench/dut/mips/dp/result\[31:0\]" \
           "/MIPS_Testbench/dut/mips/dp/srca\[31:0\]" \
           "/MIPS_Testbench/dut/mips/dp/writedata\[31:0\]" \
           "/MIPS_Testbench/dut/mips/dp/wb_dat\[31:0\]"
wvSetPosition -win $_nWave2 {("G5" 0)}
wvSetPosition -win $_nWave2 {("G5" 9)}
wvSetPosition -win $_nWave2 {("G5" 9)}
verdiSetActWin -win $_nWave2
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvSetCursor -win $_nWave2 15.418357 -snap {("G5" 1)}
wvSetCursor -win $_nWave2 14.930435 -snap {("G5" 2)}
wvSelectSignal -win $_nWave2 {( "G5" 2 )} 
verdiWindowResize -win $_Verdi_1 "1280" "64" "1222" "1129"
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvSetCursor -win $_nWave2 5.074396 -snap {("G5" 8)}
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 8
wvScrollUp -win $_nWave2 1
wvSelectSignal -win $_nWave2 {( "G1" 2 )} 
wvSetPosition -win $_nWave2 {("G1" 2)}
wvSetPosition -win $_nWave2 {("G1" 3)}
wvSetPosition -win $_nWave2 {("G1" 5)}
wvSetPosition -win $_nWave2 {("dmem" 0)}
wvSetPosition -win $_nWave2 {("G3" 0)}
wvSetPosition -win $_nWave2 {("G4" 2)}
wvSetPosition -win $_nWave2 {("G4" 5)}
wvSetPosition -win $_nWave2 {("G4" 6)}
wvSetPosition -win $_nWave2 {("G4" 8)}
wvSetPosition -win $_nWave2 {("G5" 0)}
wvSetPosition -win $_nWave2 {("G5" 1)}
wvSetPosition -win $_nWave2 {("G5" 2)}
wvSetPosition -win $_nWave2 {("G5" 1)}
wvSetPosition -win $_nWave2 {("G5" 2)}
wvSetPosition -win $_nWave2 {("G5" 3)}
wvSetPosition -win $_nWave2 {("G5" 4)}
wvSetPosition -win $_nWave2 {("G5" 5)}
wvSetPosition -win $_nWave2 {("G5" 6)}
wvSetPosition -win $_nWave2 {("G5" 7)}
wvSetPosition -win $_nWave2 {("G5" 8)}
wvSetPosition -win $_nWave2 {("G5" 9)}
wvSetPosition -win $_nWave2 {("G6" 0)}
wvSetPosition -win $_nWave2 {("G5" 9)}
wvSetPosition -win $_nWave2 {("G5" 6)}
wvSetPosition -win $_nWave2 {("G5" 2)}
wvSetPosition -win $_nWave2 {("G5" 1)}
wvSetPosition -win $_nWave2 {("G5" 0)}
wvSetPosition -win $_nWave2 {("G4" 8)}
wvSetPosition -win $_nWave2 {("G5" 0)}
wvMoveSelected -win $_nWave2
wvSetPosition -win $_nWave2 {("G5" 1)}
wvScrollDown -win $_nWave2 0
srcDeselectAll -win $_nTrace1
srcSelect -signal "logicwrite" -line 51 -pos 1 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcActiveTrace "MIPS_Testbench.dut.mips.dp.logicwrite" -win $_nTrace1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
verdiSetActWin -win $_nWave2
srcHBSelect "MIPS_Testbench.dut.mips.dp" -win $_nTrace1
srcSetScope "MIPS_Testbench.dut.mips.dp" -delim "." -win $_nTrace1
srcHBSelect "MIPS_Testbench.dut.mips.dp" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcDeselectAll -win $_nTrace1
srcSelect -signal "writedata" -line 51 -pos 1 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcDeselectAll -win $_nTrace1
srcSelect -signal "writedata" -line 57 -pos 1 -win $_nTrace1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
verdiSetActWin -win $_nWave2
wvSetPosition -win $_nWave2 {("G4" 0)}
wvSetPosition -win $_nWave2 {("G4" 1)}
wvSetPosition -win $_nWave2 {("G4" 7)}
wvSetPosition -win $_nWave2 {("G5" 10)}
wvSetPosition -win $_nWave2 {("G5" 8)}
wvSetPosition -win $_nWave2 {("G5" 9)}
wvSetPosition -win $_nWave2 {("G5" 10)}
wvSetPosition -win $_nWave2 {("G6" 0)}
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvAddSignal -win $_nWave2 "/MIPS_Testbench/dut/mips/dp/writedata\[31:0\]"
wvSetPosition -win $_nWave2 {("G6" 0)}
wvSetPosition -win $_nWave2 {("G6" 1)}
wvSetPosition -win $_nWave2 {("G6" 1)}
verdiSetActWin -win $_nWave2
wvScrollDown -win $_nWave2 1
srcDeselectAll -win $_nTrace1
srcSelect -signal "signimm" -line 57 -pos 1 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvSetPosition -win $_nWave2 {("G4" 4)}
wvSetPosition -win $_nWave2 {("G4" 6)}
wvSetPosition -win $_nWave2 {("G4" 8)}
wvSetPosition -win $_nWave2 {("G5" 10)}
wvSetPosition -win $_nWave2 {("G5" 7)}
wvSetPosition -win $_nWave2 {("G5" 8)}
wvSetPosition -win $_nWave2 {("G5" 9)}
wvSetPosition -win $_nWave2 {("G5" 10)}
wvSetPosition -win $_nWave2 {("G6" 0)}
wvSetPosition -win $_nWave2 {("G6" 1)}
wvSetPosition -win $_nWave2 {("G7" 0)}
wvSetPosition -win $_nWave2 {("G6" 1)}
wvAddSignal -win $_nWave2 "/MIPS_Testbench/dut/mips/dp/signimm\[31:0\]"
wvSetPosition -win $_nWave2 {("G6" 1)}
wvSetPosition -win $_nWave2 {("G6" 2)}
srcDeselectAll -win $_nTrace1
srcSelect -inst "srcbmux" -line 57 -pos 1 -win $_nTrace1
srcAction -pos 56 8 2 -win $_nTrace1 -name "srcbmux" -ctrlKey off
srcBackwardHistory -win $_nTrace1
srcHBSelect "MIPS_Testbench.dut.mips.dp.srcbmux" -win $_nTrace1
srcHBSelect "MIPS_Testbench.dut.mips.dp" -win $_nTrace1
verdiSetActWin -win $_nWave2
wvScrollDown -win $_nWave2 1
srcDeselectAll -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcDeselectAll -win $_nTrace1
srcSelect -signal "writedata" -line 57 -pos 1 -win $_nTrace1
srcActiveTrace "MIPS_Testbench.dut.mips.dp.writedata\[31:0\]" -win $_nTrace1
srcBackwardHistory -win $_nTrace1
srcHBSelect "MIPS_Testbench.dut.mips.dp.rf" -win $_nTrace1
srcHBSelect "MIPS_Testbench.dut.mips.dp" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "writedata" -line 51 -pos 1 -win $_nTrace1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
verdiSetActWin -win $_nWave2
wvSelectSignal -win $_nWave2 {( "G6" 1 )} 
srcDeselectAll -win $_nTrace1
srcSelect -inst "rf" -line 51 -pos 1 -win $_nTrace1
srcAction -pos 50 3 0 -win $_nTrace1 -name "rf" -ctrlKey off
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcDeselectAll -win $_nTrace1
srcSelect -signal "ra2" -line 69 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G4" 7)}
wvSetPosition -win $_nWave2 {("G4" 8)}
wvSetPosition -win $_nWave2 {("G5" 2)}
wvSetPosition -win $_nWave2 {("G5" 3)}
wvSetPosition -win $_nWave2 {("G5" 4)}
wvSetPosition -win $_nWave2 {("G5" 6)}
wvSetPosition -win $_nWave2 {("G5" 7)}
wvSetPosition -win $_nWave2 {("G5" 8)}
wvSetPosition -win $_nWave2 {("G5" 9)}
wvSetPosition -win $_nWave2 {("G5" 10)}
wvSetPosition -win $_nWave2 {("G6" 0)}
wvAddSignal -win $_nWave2 "/MIPS_Testbench/dut/mips/dp/rf/ra2\[4:0\]"
wvSetPosition -win $_nWave2 {("G6" 0)}
wvSetPosition -win $_nWave2 {("G6" 1)}
verdiSetActWin -win $_nWave2
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 0
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcDeselectAll -win $_nTrace1
srcSelect -signal "rd2" -line 71 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G4" 6)}
wvSetPosition -win $_nWave2 {("G5" 3)}
wvSetPosition -win $_nWave2 {("G5" 5)}
wvSetPosition -win $_nWave2 {("G5" 8)}
wvSetPosition -win $_nWave2 {("G6" 2)}
wvSetPosition -win $_nWave2 {("G6" 1)}
wvAddSignal -win $_nWave2 "/MIPS_Testbench/dut/mips/dp/rf/rd2\[31:0\]"
wvSetPosition -win $_nWave2 {("G6" 1)}
wvSetPosition -win $_nWave2 {("G6" 2)}
verdiSetActWin -win $_nWave2
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 0
srcDeselectAll -win $_nTrace1
srcSelect -signal "wd3" -line 81 -pos 1 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvSetPosition -win $_nWave2 {("G5" 1)}
wvSetPosition -win $_nWave2 {("G6" 2)}
wvSetPosition -win $_nWave2 {("G6" 4)}
wvSetPosition -win $_nWave2 {("G7" 0)}
wvSetPosition -win $_nWave2 {("G6" 2)}
wvSetPosition -win $_nWave2 {("G7" 0)}
wvSetPosition -win $_nWave2 {("G6" 4)}
wvAddSignal -win $_nWave2 "/MIPS_Testbench/dut/mips/dp/rf/wd3\[31:0\]"
wvSetPosition -win $_nWave2 {("G6" 4)}
wvSetPosition -win $_nWave2 {("G6" 5)}
verdiSetActWin -win $_nWave2
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 0
srcDeselectAll -win $_nTrace1
srcSelect -signal "rf\[wa3\]" -line 81 -pos 1 -partailSelPos 4 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvSetPosition -win $_nWave2 {("G4" 6)}
wvSetPosition -win $_nWave2 {("G6" 2)}
wvSetPosition -win $_nWave2 {("G6" 3)}
wvSetPosition -win $_nWave2 {("G6" 2)}
wvSetPosition -win $_nWave2 {("G7" 0)}
wvSetPosition -win $_nWave2 {("G6" 5)}
wvSetPosition -win $_nWave2 {("G6" 4)}
wvAddSignal -win $_nWave2 "/MIPS_Testbench/dut/mips/dp/rf/wa3\[4:0\]"
wvSetPosition -win $_nWave2 {("G6" 4)}
wvSetPosition -win $_nWave2 {("G6" 5)}
verdiSetActWin -win $_nWave2
wvScrollDown -win $_nWave2 1
wvSelectSignal -win $_nWave2 {( "G6" 4 )} 
wvShowOneTraceSignals -win $_nWave2 -signal \
           "/MIPS_Testbench/dut/mips/dp/signimm\[31:0\]" -driver
srcBackwardHistory -win $_nTrace1
srcHBSelect "MIPS_Testbench.dut.mips.dp.se" -win $_nTrace1
srcHBSelect "MIPS_Testbench.dut.mips.dp.rf" -win $_nTrace1
srcBackwardHistory -win $_nTrace1
srcHBSelect "MIPS_Testbench.dut.mips.dp.rf" -win $_nTrace1
srcHBSelect "MIPS_Testbench.dut.mips.dp" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "writereg" -line 51 -pos 1 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcActiveTrace "MIPS_Testbench.dut.mips.dp.writereg\[4:0\]" -win $_nTrace1
srcActiveTrace "MIPS_Testbench.dut.mips.dp.wrmux.y\[4:0\]" -win $_nTrace1
srcBackwardHistory -win $_nTrace1
srcHBSelect "MIPS_Testbench.dut.mips.dp.wrmux" -win $_nTrace1
srcHBSelect "MIPS_Testbench.dut.mips.dp.wrmux" -win $_nTrace1
srcBackwardHistory -win $_nTrace1
srcHBSelect "MIPS_Testbench.dut.mips.dp.wrmux" -win $_nTrace1
srcHBSelect "MIPS_Testbench.dut.mips.dp" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcHBSelect "MIPS_Testbench.dut.mips.c" -win $_nTrace1
srcSetScope "MIPS_Testbench.dut.mips.c" -delim "." -win $_nTrace1
srcHBSelect "MIPS_Testbench.dut.mips.c" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
verdiSetActWin -win $_nWave2
wvScrollUp -win $_nWave2 4
wvScrollUp -win $_nWave2 15
wvScrollDown -win $_nWave2 22
wvCollapseGroup -win $_nWave2 \
           "G6//MIPS_Testbench/dut/mips/dp/signimm@0\(1s\)#ActiveDriver"
wvScrollUp -win $_nWave2 1
wvSelectSignal -win $_nWave2 {( "G5" 1 )} 
srcDeselectAll -win $_nTrace1
srcSelect -signal "op" -line 23 -pos 1 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvSetPosition -win $_nWave2 {("G4" 7)}
wvSetPosition -win $_nWave2 {("G4" 8)}
wvSetPosition -win $_nWave2 {("G6" 2)}
wvSetPosition -win $_nWave2 {("G5" 6)}
wvSetPosition -win $_nWave2 {("G5" 5)}
wvSetPosition -win $_nWave2 {("G5" 4)}
wvSetPosition -win $_nWave2 {("G5" 3)}
wvSetPosition -win $_nWave2 {("G5" 2)}
wvSetPosition -win $_nWave2 {("G5" 1)}
wvAddSignal -win $_nWave2 "/MIPS_Testbench/dut/mips/c/op\[5:0\]"
wvSetPosition -win $_nWave2 {("G5" 1)}
wvSetPosition -win $_nWave2 {("G5" 2)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "funct" -line 24 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G5" 0)}
wvSetPosition -win $_nWave2 {("G5" 5)}
wvSetPosition -win $_nWave2 {("G5" 4)}
wvSetPosition -win $_nWave2 {("G5" 3)}
wvSetPosition -win $_nWave2 {("G5" 2)}
wvAddSignal -win $_nWave2 "/MIPS_Testbench/dut/mips/c/funct\[5:0\]"
wvSetPosition -win $_nWave2 {("G5" 2)}
wvSetPosition -win $_nWave2 {("G5" 3)}
wvSelectGroup -win $_nWave2 {G6}
verdiSetActWin -win $_nWave2
wvSelectSignal -win $_nWave2 {( "G6" 2 )} 
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
srcHBSelect "MIPS_Testbench.dut.mips.dp.rf" -win $_nTrace1
srcSetScope "MIPS_Testbench.dut.mips.dp.rf" -delim "." -win $_nTrace1
srcHBSelect "MIPS_Testbench.dut.mips.dp.rf" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
verdiSetActWin -win $_nWave2
wvScrollDown -win $_nWave2 2
wvSelectGroup -win $_nWave2 \
           {G6//MIPS_Testbench/dut/mips/dp/signimm@0(1s)#ActiveDriver}
wvSelectSignal -win $_nWave2 {( "G6" 9 )} 
srcDeselectAll -win $_nTrace1
srcSelect -signal "wd3" -line 70 -pos 1 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcDeselectAll -win $_nTrace1
srcSelect -signal "wa3" -line 69 -pos 1 -win $_nTrace1
srcActiveTrace "MIPS_Testbench.dut.mips.dp.rf.wa3\[4:0\]" -win $_nTrace1
srcBackwardHistory -win $_nTrace1
srcHBSelect "MIPS_Testbench.dut.mips.dp.wrmux" -win $_nTrace1
srcHBSelect "MIPS_Testbench.dut.mips.dp.rf" -win $_nTrace1
srcHBSelect "MIPS_Testbench.dut.mips.dp" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "MIPS_Testbench.dut.mips.dp" -win $_nTrace1
srcSetScope "MIPS_Testbench.dut.mips.dp" -delim "." -win $_nTrace1
srcHBSelect "MIPS_Testbench.dut.mips.dp" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "instr\[25:21\]" -line 51 -pos 1 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcDeselectAll -win $_nTrace1
srcSelect -signal "instr\[20:16\]" -line 51 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "writereg" -line 51 -pos 1 -win $_nTrace1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
verdiSetActWin -win $_nWave2
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvSelectSignal -win $_nWave2 {( "G6" 1 )} 
wvSelectSignal -win $_nWave2 {( "G6" 2 )} 
wvSelectSignal -win $_nWave2 {( "G5" 7 )} 
wvSelectSignal -win $_nWave2 {( "G5" 8 )} 
wvSelectSignal -win $_nWave2 {( "G6" 2 )} 
wvSelectSignal -win $_nWave2 {( "G6" 1 )} 
wvSelectSignal -win $_nWave2 {( "G6" 2 )} 
wvSelectSignal -win $_nWave2 {( "G6" 4 )} 
wvSelectSignal -win $_nWave2 {( "G6" 1 )} 
srcDeselectAll -win $_nTrace1
srcSelect -inst "rf" -line 51 -pos 1 -win $_nTrace1
srcAction -pos 50 3 1 -win $_nTrace1 -name "rf" -ctrlKey off
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcDeselectAll -win $_nTrace1
srcSelect -signal "ra1" -line 69 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G5" 7)}
wvSetPosition -win $_nWave2 {("G5" 9)}
wvSetPosition -win $_nWave2 {("G5" 10)}
wvSetPosition -win $_nWave2 {("G5" 11)}
wvSetPosition -win $_nWave2 {("G5" 12)}
wvSetPosition -win $_nWave2 {("G6" 0)}
wvSetPosition -win $_nWave2 {("G6" 1)}
wvAddSignal -win $_nWave2 "/MIPS_Testbench/dut/mips/dp/rf/ra1\[4:0\]"
wvSetPosition -win $_nWave2 {("G6" 1)}
wvSetPosition -win $_nWave2 {("G6" 2)}
wvSetPosition -win $_nWave2 {("G6" 1)}
wvSetPosition -win $_nWave2 {("G6" 0)}
verdiSetActWin -win $_nWave2
wvMoveSelected -win $_nWave2
wvSetPosition -win $_nWave2 {("G6" 0)}
wvSetPosition -win $_nWave2 {("G6" 1)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "rd1" -line 71 -pos 1 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvSetPosition -win $_nWave2 {("G5" 10)}
wvSetPosition -win $_nWave2 {("G5" 11)}
wvSetPosition -win $_nWave2 {("G5" 12)}
wvSetPosition -win $_nWave2 {("G6" 0)}
wvSetPosition -win $_nWave2 {("G6" 1)}
wvAddSignal -win $_nWave2 "/MIPS_Testbench/dut/mips/dp/rf/rd1\[31:0\]"
wvSetPosition -win $_nWave2 {("G6" 1)}
wvSetPosition -win $_nWave2 {("G6" 2)}
wvSelectSignal -win $_nWave2 {( "G6" 3 )} 
verdiSetActWin -win $_nWave2
wvSelectSignal -win $_nWave2 {( "G6" 4 )} 
wvScrollDown -win $_nWave2 2
wvSelectSignal -win $_nWave2 {( "G6" 3 )} 
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvSelectSignal -win $_nWave2 {( "G5" 1 )} 
wvSetPosition -win $_nWave2 {("G5" 1)}
wvSetPosition -win $_nWave2 {("G5" 2)}
wvSetPosition -win $_nWave2 {("G5" 4)}
wvSetPosition -win $_nWave2 {("G5" 8)}
wvSetPosition -win $_nWave2 {("G5" 9)}
wvSetPosition -win $_nWave2 {("G6" 0)}
wvSetPosition -win $_nWave2 {("G6" 2)}
wvSetPosition -win $_nWave2 {("G6" 3)}
wvSetPosition -win $_nWave2 {("G6" 2)}
wvSetPosition -win $_nWave2 {("G6" 1)}
wvSetPosition -win $_nWave2 {("G6" 0)}
wvMoveSelected -win $_nWave2
wvSetPosition -win $_nWave2 {("G6" 1)}
wvScrollDown -win $_nWave2 4
srcBackwardHistory -win $_nTrace1
srcHBSelect "MIPS_Testbench.dut.mips.dp.rf" -win $_nTrace1
srcHBSelect "MIPS_Testbench.dut.mips.dp" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "alusrc" -line 57 -pos 1 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvSetPosition -win $_nWave2 {("G5" 3)}
wvSetPosition -win $_nWave2 {("G5" 2)}
wvSetPosition -win $_nWave2 {("G6" 3)}
wvSetPosition -win $_nWave2 {("G5" 6)}
wvSetPosition -win $_nWave2 {("G5" 7)}
wvSetPosition -win $_nWave2 {("G5" 8)}
wvSetPosition -win $_nWave2 {("G5" 9)}
wvSetPosition -win $_nWave2 {("G5" 11)}
wvSetPosition -win $_nWave2 {("G6" 0)}
wvSetPosition -win $_nWave2 {("G6" 1)}
wvAddSignal -win $_nWave2 "/MIPS_Testbench/dut/mips/dp/alusrc"
wvSetPosition -win $_nWave2 {("G6" 1)}
wvSetPosition -win $_nWave2 {("G6" 2)}
verdiSetActWin -win $_nWave2
wvScrollDown -win $_nWave2 3
srcDeselectAll -win $_nTrace1
srcSelect -signal "srcb" -line 57 -pos 1 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvSetPosition -win $_nWave2 {("G5" 4)}
wvSetPosition -win $_nWave2 {("G5" 5)}
wvSetPosition -win $_nWave2 {("G5" 7)}
wvSetPosition -win $_nWave2 {("G6" 3)}
wvSetPosition -win $_nWave2 {("G6" 1)}
wvSetPosition -win $_nWave2 {("G6" 2)}
wvSetPosition -win $_nWave2 {("G6" 3)}
wvSetPosition -win $_nWave2 {("G6" 2)}
wvAddSignal -win $_nWave2 "/MIPS_Testbench/dut/mips/dp/srcb\[31:0\]"
wvSetPosition -win $_nWave2 {("G6" 2)}
wvSetPosition -win $_nWave2 {("G6" 3)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "writedata" -line 57 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G5" 4)}
wvSetPosition -win $_nWave2 {("G6" 3)}
wvSetPosition -win $_nWave2 {("G6" 2)}
wvSetPosition -win $_nWave2 {("G6" 1)}
wvAddSignal -win $_nWave2 "/MIPS_Testbench/dut/mips/dp/writedata\[31:0\]"
wvSetPosition -win $_nWave2 {("G6" 1)}
wvSetPosition -win $_nWave2 {("G6" 2)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "signimm" -line 57 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G5" 3)}
wvSetPosition -win $_nWave2 {("G5" 9)}
wvSetPosition -win $_nWave2 {("G6" 3)}
wvSetPosition -win $_nWave2 {("G6" 0)}
wvSetPosition -win $_nWave2 {("G6" 1)}
wvSetPosition -win $_nWave2 {("G6" 2)}
wvSetPosition -win $_nWave2 {("G6" 3)}
wvSetPosition -win $_nWave2 {("G6" 2)}
wvAddSignal -win $_nWave2 "/MIPS_Testbench/dut/mips/dp/signimm\[31:0\]"
wvSetPosition -win $_nWave2 {("G6" 2)}
wvSetPosition -win $_nWave2 {("G6" 3)}
verdiSetActWin -win $_nWave2
wvScrollDown -win $_nWave2 2
wvSelectSignal -win $_nWave2 {( "G6" 4 )} 
wvSelectSignal -win $_nWave2 {( "G6" 5 )} 
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
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
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
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvSetCursor -win $_nWave2 5.074396 -snap {("G1" 3)}
wvSetCursor -win $_nWave2 4.976812 -snap {("G1" 4)}
wvSetCursor -win $_nWave2 4.830435 -snap {("G1" 4)}
wvSetCursor -win $_nWave2 14.979227 -snap {("G1" 4)}
wvSetCursor -win $_nWave2 14.881643 -snap {("G1" 3)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "instr\[20:16\]" -line 52 -pos 1 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
verdiSetActWin -win $_nWave2
wvScrollDown -win $_nWave2 3
wvScrollDown -win $_nWave2 24
wvScrollDown -win $_nWave2 0
wvSetPosition -win $_nWave2 {("G6" 0)}
wvCollapseGroup -win $_nWave2 "G6"
wvScrollDown -win $_nWave2 0
srcDeselectAll -win $_nTrace1
srcSelect -inst "wrmux" -line 52 -pos 1 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcSelect -win $_nTrace1 -range {51 52 6 9 3 5} -backward
srcDeselectAll -win $_nTrace1
srcSelect -inst "wrmux" -line 52 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G5" 4)}
wvSetPosition -win $_nWave2 {("G5" 6)}
wvSetPosition -win $_nWave2 {("G5" 7)}
wvSetPosition -win $_nWave2 {("G5" 8)}
wvSetPosition -win $_nWave2 {("G5" 9)}
wvSetPosition -win $_nWave2 {("G5" 11)}
wvSetPosition -win $_nWave2 {("G7" 0)}
wvAddSignal -win $_nWave2 "/MIPS_Testbench/dut/mips/dp/instr\[20:16\]" \
           "/MIPS_Testbench/dut/mips/dp/instr\[15:11\]" \
           "/MIPS_Testbench/dut/mips/dp/logicdst" \
           "/MIPS_Testbench/dut/mips/dp/writereg\[4:0\]"
wvSetPosition -win $_nWave2 {("G7" 0)}
wvSetPosition -win $_nWave2 {("G7" 4)}
wvSetPosition -win $_nWave2 {("G7" 4)}
verdiSetActWin -win $_nWave2
wvSelectSignal -win $_nWave2 {( "G7" 2 )} 
wvScrollDown -win $_nWave2 0
wvSelectSignal -win $_nWave2 {( "G7" 1 )} 
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 1
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
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
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
wvSelectSignal -win $_nWave2 {( "G1" 1 )} 
wvSelectAll -win $_nWave2
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("G7" 0)}
wvSelectGroup -win $_nWave2 {dmem} {G3} {G4} {G5} {G6} {G7} {G8}
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("G1" 0)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "instr" -line 24 -pos 1 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvAddSignal -win $_nWave2 "/MIPS_Testbench/dut/mips/dp/instr\[31:0\]"
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G1" 1)}
srcHBSelect "MIPS_Testbench.dut" -win $_nTrace1
srcSetScope "MIPS_Testbench.dut" -delim "." -win $_nTrace1
srcHBSelect "MIPS_Testbench.dut" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcDeselectAll -win $_nTrace1
srcSelect -signal "writedata" -line 15 -pos 1 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvAddSignal -win $_nWave2 "/MIPS_Testbench/dut/writedata\[31:0\]"
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G1" 2)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "dataadr" -line 15 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G1" 2)}
wvAddSignal -win $_nWave2 "/MIPS_Testbench/dut/dataadr\[31:0\]"
wvSetPosition -win $_nWave2 {("G1" 2)}
wvSetPosition -win $_nWave2 {("G1" 3)}
srcBackwardHistory -win $_nTrace1
srcHBSelect "MIPS_Testbench.dut" -win $_nTrace1
srcHBSelect "MIPS_Testbench.dut.mips.dp" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "aluout" -line 25 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G1" 3)}
wvAddSignal -win $_nWave2 "/MIPS_Testbench/dut/mips/dp/aluout\[31:0\]"
wvSetPosition -win $_nWave2 {("G1" 3)}
wvSetPosition -win $_nWave2 {("G1" 4)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "writedata" -line 25 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 3)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G1" 4)}
wvAddSignal -win $_nWave2 "/MIPS_Testbench/dut/mips/dp/writedata\[31:0\]"
wvSetPosition -win $_nWave2 {("G1" 4)}
wvSetPosition -win $_nWave2 {("G1" 5)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "writedata" -line 25 -pos 1 -win $_nTrace1
srcActiveTrace "MIPS_Testbench.dut.mips.dp.writedata\[31:0\]" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -win $_nTrace1 -range {95 97 15 1 6 1}
srcDeselectAll -win $_nTrace1
srcHBSelect "MIPS_Testbench.dut.mips.dp" -win $_nTrace1
srcSetScope "MIPS_Testbench.dut.mips.dp" -delim "." -win $_nTrace1
srcHBSelect "MIPS_Testbench.dut.mips.dp" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcDeselectAll -win $_nTrace1
srcSelect -signal "readdata" -line 26 -pos 1 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvSetPosition -win $_nWave2 {("G2" 0)}
wvAddSignal -win $_nWave2 "/MIPS_Testbench/dut/mips/dp/readdata\[31:0\]"
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G2" 1)}
wvSetPosition -win $_nWave2 {("G2" 1)}
verdiSetActWin -win $_nWave2
srcDeselectAll -win $_nTrace1
srcSelect -signal "result" -line 33 -pos 1 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvSetPosition -win $_nWave2 {("G1" 5)}
wvSetPosition -win $_nWave2 {("G3" 0)}
wvSetPosition -win $_nWave2 {("G2" 1)}
wvAddSignal -win $_nWave2 "/MIPS_Testbench/dut/mips/dp/result\[31:0\]"
wvSetPosition -win $_nWave2 {("G2" 1)}
wvSetPosition -win $_nWave2 {("G2" 2)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "memtoreg" -line 53 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 2)}
wvSetPosition -win $_nWave2 {("G1" 5)}
wvSetPosition -win $_nWave2 {("G2" 2)}
wvAddSignal -win $_nWave2 "/MIPS_Testbench/dut/mips/dp/memtoreg"
wvSetPosition -win $_nWave2 {("G2" 2)}
wvSetPosition -win $_nWave2 {("G2" 3)}
srcDeselectAll -win $_nTrace1
srcSelect -inst "rf" -line 51 -pos 1 -win $_nTrace1
srcAction -pos 50 3 1 -win $_nTrace1 -name "rf" -ctrlKey off
srcDeselectAll -win $_nTrace1
srcSelect -signal "rd2" -line 71 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 5)}
wvSetPosition -win $_nWave2 {("G3" 0)}
wvAddSignal -win $_nWave2 "/MIPS_Testbench/dut/mips/dp/rf/rd2\[31:0\]"
wvSetPosition -win $_nWave2 {("G3" 0)}
wvSetPosition -win $_nWave2 {("G3" 1)}
wvSetPosition -win $_nWave2 {("G3" 1)}
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "ra2" -line 69 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 2)}
wvSetPosition -win $_nWave2 {("G1" 3)}
wvSetPosition -win $_nWave2 {("G1" 5)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G2" 2)}
wvSetPosition -win $_nWave2 {("G2" 3)}
wvSetPosition -win $_nWave2 {("G3" 0)}
wvAddSignal -win $_nWave2 "/MIPS_Testbench/dut/mips/dp/rf/ra2\[4:0\]"
wvSetPosition -win $_nWave2 {("G3" 0)}
wvSetPosition -win $_nWave2 {("G3" 1)}
wvSetCursor -win $_nWave2 0.439130 -snap {("G3" 1)}
verdiSetActWin -win $_nWave2
wvSetCursor -win $_nWave2 15.418357 -snap {("G1" 3)}
wvSelectSignal -win $_nWave2 {( "G1" 3 )} 
wvShowOneTraceSignals -win $_nWave2 -signal "/MIPS_Testbench/dut/dataadr\[31:0\]" \
           -driver
wvUndo -win $_nWave2
wvSetPosition -win $_nWave2 \
           {("G1//MIPS_Testbench/dut/dataadr@15(1s)#ActiveDriver" 1)}
wvSetPosition -win $_nWave2 {("G1" 5)}
wvSetPosition -win $_nWave2 \
           {("G1//MIPS_Testbench/dut/dataadr@15(1s)#ActiveDriver" 0)}
wvSelectSignal -win $_nWave2 {( "G1" 3 )} 
wvSelectSignal -win $_nWave2 {( "G1" 3 )} 
wvSetRadix -win $_nWave2 -format Bin
wvSelectSignal -win $_nWave2 {( "G1" 3 )} 
wvSelectSignal -win $_nWave2 {( "G1" 3 )} 
wvSelectSignal -win $_nWave2 {( "G1" 3 )} 
wvSetRadix -win $_nWave2 -format Hex
wvSetCursor -win $_nWave2 5.903865 -snap {("G4" 0)}
wvSetCursor -win $_nWave2 4.976812 -snap {("G1" 2)}
wvSetCursor -win $_nWave2 5.025604 -snap {("G1" 6)}
wvSetCursor -win $_nWave2 15.076812 -snap {("G1" 5)}
wvSetCursor -win $_nWave2 5.269565 -snap {("G1" 6)}
srcHBSelect "MIPS_Testbench.dut.mips.dp.se" -win $_nTrace1
srcSetScope "MIPS_Testbench.dut.mips.dp.se" -delim "." -win $_nTrace1
srcHBSelect "MIPS_Testbench.dut.mips.dp.se" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "MIPS_Testbench.dut.mips.dp.se" -win $_nTrace1
srcSetScope "MIPS_Testbench.dut.mips.dp.rf" -delim "." -win $_nTrace1
srcHBSelect "MIPS_Testbench.dut.mips.dp.rf" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "wa3" -line 69 -pos 1 -win $_nTrace1
srcAction -pos 68 15 0 -win $_nTrace1 -name "wa3" -ctrlKey off
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcBackwardHistory -win $_nTrace1
srcHBSelect "MIPS_Testbench.dut.mips.dp.wrmux" -win $_nTrace1
srcHBSelect "MIPS_Testbench.dut.mips.dp.rf" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "wa3" -line 69 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 3)}
wvSetPosition -win $_nWave2 {("G1" 5)}
wvSetPosition -win $_nWave2 {("G1" 6)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G2" 1)}
wvSetPosition -win $_nWave2 {("G2" 3)}
wvSetPosition -win $_nWave2 {("G3" 0)}
wvSetPosition -win $_nWave2 {("G3" 1)}
wvSetPosition -win $_nWave2 {("G3" 2)}
wvAddSignal -win $_nWave2 "/MIPS_Testbench/dut/mips/dp/rf/wa3\[4:0\]"
wvSetPosition -win $_nWave2 {("G3" 2)}
wvSetPosition -win $_nWave2 {("G3" 3)}
debExit
