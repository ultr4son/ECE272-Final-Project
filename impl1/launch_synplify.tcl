#-- Lattice Semiconductor Corporation Ltd.
#-- Synplify OEM project file C:/lscc/diamond/3.10_x64/bin/nt64/finalproject/impl1/launch_synplify.tcl
#-- Written on Tue Jun  5 20:38:48 2018

project -close
set filename "C:/lscc/diamond/3.10_x64/bin/nt64/finalproject/impl1/impl1_syn.prj"
if ([file exists "$filename"]) {
	project -load "$filename"
	project_file -remove *
} else {
	project -new "$filename"
}
set create_new 0

#device options
set_option -technology MACHXO3LF
set_option -part LCMXO3LF_6900C
set_option -package BG256C
set_option -speed_grade -5

if {$create_new == 1} {
#-- add synthesis options
	set_option -symbolic_fsm_compiler true
	set_option -resource_sharing true
	set_option -vlog_std v2001
	set_option -frequency auto
	set_option -maxfan 1000
	set_option -auto_constrain_io 0
	set_option -disable_io_insertion false
	set_option -retiming false; set_option -pipe true
	set_option -force_gsr false
	set_option -compiler_compatible 0
	set_option -dup false
	set_option -frequency 1
	set_option -default_enum_encoding default
	
	
	
	set_option -write_apr_constraint 1
	set_option -fix_gated_and_generated_clocks 1
	set_option -update_models_cp 0
	set_option -resolve_multiple_driver 0
	
	
}
#-- add_file options
set_option -include_path "C:/lscc/diamond/3.10_x64/bin/nt64/finalproject"
add_file -verilog "C:/Users/Tristan Thompson/Documents/section4code/Clock_Counter.sv"
add_file -verilog "C:/lscc/diamond/3.10_x64/bin/nt64/finalproject/PhysicsController.sv"
add_file -verilog "C:/lscc/diamond/3.10_x64/bin/nt64/finalproject/Game_FSM.sv"
add_file -verilog "C:/Users/Tristan Thompson/Downloads/hvsync_generator/hvsync_generator.sv"
add_file -verilog "C:/lscc/diamond/3.10_x64/bin/nt64/finalproject/Game.sv"
add_file -verilog "C:/lscc/diamond/3.10_x64/bin/nt64/finalproject/Top.sv"
add_file -verilog "C:/lscc/diamond/3.10_x64/bin/nt64/finalproject/Renderer.sv"
#-- top module name
set_option -top_module {}
project -result_file {C:/lscc/diamond/3.10_x64/bin/nt64/finalproject/impl1/impl1.edi}
project -save "$filename"
