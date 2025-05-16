# ########################################################
# Create project
set PROJ "psx_HLS"
open_project -reset $PROJ 

# Add design files
add_files pr1hpAXI_HLS.cpp

# Set the top-level function
set_top pr1hpAXI_HLS

# Add testbench & golden output files
add_files -tb "pr1hpAXI_HLS_tb.cpp out_gold.dat" 


# ########################################################
# Create solution

# Open solution
set SOLN "solution1"
open_solution -reset $SOLN -flow_target vivado

# Define technology and clock rate
set XPART xc7a100tcsg324-1
set CLKP 10.0
set_part $XPART
create_clock -period $CLKP
config_rtl -reset all -reset_level low


# ########################################################
# Vitis HLS degign flow

set CSIM 1
set CSYNTH 1
set COSIM 1
set VIVADO_SYN 0
set VIVADO_IMPL 1

# C Simulation
if {$CSIM == 1} {
  csim_design 
}

# C Synthesis
if {$CSYNTH == 1} {
  csynth_design
}

# C/RTL Co-Simulation
if {$COSIM == 1} {
  cosim_design -rtl vhdl
}

# Export RTL & Vivado Logic Synthesis
if {$VIVADO_SYN == 1} {
  # Add -trace_level port to generate .wdb file
  export_design -format ip_catalog -rtl vhdl -display_name "pr7hp_HLS" -flow syn
}

# Export RTL & Vivado Logic Synthesis, Place and Route
if {$VIVADO_IMPL == 1} {
  # Add -trace_level port to generate .wdb file
  export_design -format ip_catalog -rtl vhdl -display_name "pr7hp_HLS" -flow impl
}

exit

