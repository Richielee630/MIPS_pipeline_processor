# Clock Signal
set_property -dict {PACKAGE_PIN W5 IOSTANDARD LVCMOS33}           [get_ports {clk}];          
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {clk}];

# Buttons
set_property -dict {PACKAGE_PIN U18 IOSTANDARD LVCMOS33} [get_ports {button}]; # Center Button
set_property -dict {PACKAGE_PIN W19 IOSTANDARD LVCMOS33} [get_ports {rst}]; # Left Button

# Switches
set_property -dict {PACKAGE_PIN V17 IOSTANDARD LVCMOS33} [get_ports {switches[0]}];  # Switch 0
set_property -dict {PACKAGE_PIN V16 IOSTANDARD LVCMOS33} [get_ports {switches[1]}];  # Switch 1
set_property -dict {PACKAGE_PIN W16 IOSTANDARD LVCMOS33} [get_ports {switches[2]}];  # Switch 2
set_property -dict {PACKAGE_PIN W17 IOSTANDARD LVCMOS33} [get_ports {switches[3]}];  # Switch 3
set_property -dict {PACKAGE_PIN W15 IOSTANDARD LVCMOS33} [get_ports {switches[4]}];  # Switch 4
set_property -dict {PACKAGE_PIN V15 IOSTANDARD LVCMOS33} [get_ports {switches[5]}];  # Switch 5
set_property -dict {PACKAGE_PIN W14 IOSTANDARD LVCMOS33} [get_ports {switches[6]}];  # Switch 6
set_property -dict {PACKAGE_PIN W13 IOSTANDARD LVCMOS33} [get_ports {switches[7]}];  # Switch 7
set_property -dict {PACKAGE_PIN V2  IOSTANDARD LVCMOS33} [get_ports {switches[8]}];  # Switch 8

set_property -dict {PACKAGE_PIN R3  IOSTANDARD LVCMOS33} [get_ports {switches[9]}];   # Switch 11 N[0]
set_property -dict {PACKAGE_PIN W2  IOSTANDARD LVCMOS33} [get_ports {switches[10]}];  # Switch 12 N[1]
set_property -dict {PACKAGE_PIN U1  IOSTANDARD LVCMOS33} [get_ports {switches[11]}];  # Switch 13 N[2]
set_property -dict {PACKAGE_PIN T1  IOSTANDARD LVCMOS33} [get_ports {switches[12]}];  # Switch 14 N[3]
set_property -dict {PACKAGE_PIN R2  IOSTANDARD LVCMOS33} [get_ports {switches[13]}];  # Switch 15 sel

# LEDs
set_property -dict {PACKAGE_PIN U16 IOSTANDARD LVCMOS33} [get_ports {we_dmM}];  # LED 0

set_property -dict {PACKAGE_PIN U3 IOSTANDARD LVCMOS33} [get_ports {factErr[0]}];  # factErr0
set_property -dict {PACKAGE_PIN P3 IOSTANDARD LVCMOS33} [get_ports {factErr[1]}];  # factErr1
set_property -dict {PACKAGE_PIN N3 IOSTANDARD LVCMOS33} [get_ports {factErr[2]}];  # factErr2
set_property -dict {PACKAGE_PIN P1 IOSTANDARD LVCMOS33} [get_ports {factErr[3]}];  # factErr3
set_property -dict {PACKAGE_PIN L1 IOSTANDARD LVCMOS33} [get_ports {dispSe}];  # dispSe
  
# 7 segment display
set_property -dict {PACKAGE_PIN W7 IOSTANDARD LVCMOS33} [get_ports {LEDOUT[0]}]; # CA
set_property -dict {PACKAGE_PIN W6 IOSTANDARD LVCMOS33} [get_ports {LEDOUT[1]}]; # CB
set_property -dict {PACKAGE_PIN U8 IOSTANDARD LVCMOS33} [get_ports {LEDOUT[2]}]; # CC
set_property -dict {PACKAGE_PIN V8 IOSTANDARD LVCMOS33} [get_ports {LEDOUT[3]}]; # CD
set_property -dict {PACKAGE_PIN U5 IOSTANDARD LVCMOS33} [get_ports {LEDOUT[4]}]; # CE
set_property -dict {PACKAGE_PIN V5 IOSTANDARD LVCMOS33} [get_ports {LEDOUT[5]}]; # CF
set_property -dict {PACKAGE_PIN U7 IOSTANDARD LVCMOS33} [get_ports {LEDOUT[6]}]; # CG
set_property -dict {PACKAGE_PIN V7 IOSTANDARD LVCMOS33} [get_ports {LEDOUT[7]}]; # DP

set_property -dict {PACKAGE_PIN U2 IOSTANDARD LVCMOS33} [get_ports {LEDSEL[0]}]; # AN0
set_property -dict {PACKAGE_PIN U4 IOSTANDARD LVCMOS33} [get_ports {LEDSEL[1]}]; # AN1
set_property -dict {PACKAGE_PIN V4 IOSTANDARD LVCMOS33} [get_ports {LEDSEL[2]}]; # AN2
set_property -dict {PACKAGE_PIN W4 IOSTANDARD LVCMOS33} [get_ports {LEDSEL[3]}]; # AN3