//Copyright (C)2014-2025 GOWIN Semiconductor Corporation.
//All rights reserved.
//File Title: Timing Constraints file
//Tool Version: V1.9.11.03 (64-bit) 
//Created Time: 2025-08-01 14:40:12
create_clock -name sys_clk -period 20 -waveform {0 10} [get_ports {sys_clk}]
create_clock -name mclk -period 12.5 -waveform {0 6.25} [get_pins {u_Gowin_PLLVR/pllvr_inst/CLKOUT}]
