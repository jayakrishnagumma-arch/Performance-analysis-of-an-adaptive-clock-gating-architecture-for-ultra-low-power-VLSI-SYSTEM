# Vivado project creation script
# Run from Vivado Tcl Console:
# source vivado/create_project.tcl

set project_name "Adaptive_Clock_Gating"
set project_dir  "./vivado/$project_name"
set part_name    "xc7a35tcpg236-1"

create_project $project_name $project_dir -part $part_name -force

add_files [glob ./src/*.v]
add_files -fileset sim_1 [glob ./sim/*.v]

set_property top adaptive_clock_gating_top [get_filesets sources_1]
set_property top adaptive_clock_gating_tb [get_filesets sim_1]

update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

puts "Project created: $project_name"
puts "Change -part to your FPGA part if your board uses a different device."
