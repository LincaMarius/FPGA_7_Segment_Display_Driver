`timescale 1ns/1ns

// Verilog code for test bench for Aplication 1
// who uses
// BCD to one Digit 7-Segment Display FPGA Driver

module Aplication_1_tb;

// input signals of the mode under test
reg clk50MHz_tb;
reg rst_n;

// output signals of the module under test
wire[6:0] SEG_tb;
reg dp_tb;
reg SEL7_tb;

initial
begin
// initial conditions
	clk50MHz_tb = 1'b0;
	rst_n = 1'b0;
	#100 rst_n = 1'b1;	
end

// we generate a clock signal with a frequency of 50 MHz
always#10 clk50MHz_tb = ~clk50MHz_tb;

// we declare the components under test
BCD_to_1_Digit dut
(
	.clk50MHz	(clk50MHz_tb),
	.rst_n		(rst_n),
	.Segments 	(SEG_tb),
	.dp			(dp_tb),
	.SEL7			(SEL7_tb)
);
	
endmodule 