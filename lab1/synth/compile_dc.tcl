#/**************************************************/
#/* Compile Script for Synopsys                    */
#/*                                                */
#/* dc_shell-t -f compile_dc.tcl                   */
#/*                                                */
#/* OSU FreePDK 45nm                               */
#/**************************************************/

#/* All verilog files, separated by spaces         */
set my_verilog_files [list ../fifo.sv]

#/* Top-level Module                               */
set my_toplevel   fifo

#/* The name of the clock pin. If no clock-pin     */
#/* exists, pick anything                          */
set my_write_clock_pin wclk
set my_read_clock_pin rclk

#/* Target frequency in MHz for optimization       */
set my_write_clk_freq_MHz 826.4
set my_read_clk_freq_Mhz 460.2

#/* Delay of input signals (Clock-to-Q, Package etc.)  */
set my_input_delay_ns 0.1

#/* Reserved time for output signals (Holdtime etc.)   */
set my_output_delay_ns 0.1


#/**************************************************/
#/* No modifications needed below                  */
#/**************************************************/
set OSU_FREEPDK [format "%s%s"  [getenv "PDK_DIR"] "/osu_soc/lib/files"]
set search_path [concat  $search_path $OSU_FREEPDK]
set alib_library_analysis_path $OSU_FREEPDK

set link_library [set target_library [concat  [list gscl45nm.db] [list dw_foundation.sldb]]]
set target_library "gscl45nm.db"
define_design_lib WORK -path ./WORK
set verilogout_show_unconnected_pins "true"
set_ultra_optimization true
set_ultra_optimization -force

analyze -f sverilog $my_verilog_files

elaborate $my_toplevel

current_design $my_toplevel

link
uniquify

set my_write_period [expr 1000 / $my_write_clk_freq_MHz]
set my_read_period [expr 1000 / $my_read_clk_freq_Mhz]

#set find_clock [ find port [list $my_write_clock_pin $my_read_clock_pin] ]
#if {  $find_clock != [list] } {
#   set write_clk_name $my_write_clock_pin
#   set read_clk_name $my_read_clock_pin
#   create_clock -period $my_write_period $write_clk_name
#   create_clock -period $my_read_period $read_clk_name
#} else {
#   set clk_name vclk
#   create_clock -period $my_period -name $clk_name
#}

create_clock -period $my_write_period -name wclk [get_ports $my_write_clock_pin]
create_clock -period $my_read_period -name rclk [get_ports $my_read_clock_pin]

set_driving_cell  -lib_cell INVX1  [all_inputs]
set_input_delay $my_input_delay_ns -clock $write_clk_name [remove_from_collection [all_inputs] $my_write_clock_pin]
set_output_delay $my_output_delay_ns -clock $write_clk_name [all_outputs]
set_input_delay $my_input_delay_ns -clock $read_clk_name [remove_from_collection [all_inputs] $my_read_clock_pin]
set_output delay $my_output_delay_ns -clock $read_clk_name [all_outputs]

compile -ungroup_all -map_effort medium

compile -incremental_mapping -map_effort medium

check_design
report_constraint -all_violators

#set filename [format "%s%s"  $my_toplevel ".vh"]
#write -f verilog -output $filename

#set filename [format "%s%s"  $my_toplevel ".sdc"]
#write_sdc $filename

#set filename [format "%s%s"  $my_toplevel ".db"]
#write -f db -hier -output $filename -xg_force_db

redirect timing.rep { report_timing }
redirect cell.rep { report_cell }
redirect power.rep { report_power }
redirect area.rep { report_area }

quit
