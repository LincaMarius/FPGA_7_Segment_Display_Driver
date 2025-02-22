`timescale 1ns/1ns

// Verilog code for test bench fot BCD to one Digit 7-Segment Display FPGA Driver

module BCD_to_1_Digit_CA_tb;

// input signals of the mode under test
wire[3:0] BCD_tb;

// output signals of the module under test
wire[6:0] SEG_tb;
reg dp_tb;
reg SEL7_tb;

// other input signals
reg clk_tb;
reg rst_n;

// other output signals
reg clk2Hz_tb;

initial
begin
	clk_tb = 1'b0;
	rst_n = 1'b0;
	#100 rst_n = 1'b1;	
end

// we generate a clock signal with a frequency of 50 MHz
always#10 clk_tb = ~clk_tb;

// we declare the components under test
BCD_to_1_Digit_CA dut
(
	.BCD_in		(BCD_tb),
	.dp_in		(BCD_tb[0]),
	.Segments 	(SEG_tb),
	.dp			(dp_tb),
	.SEL7			(SEL7_tb)
);

// we declare other components that help the test
Clk_2Hz clk2Hz
(
	.clk_in 		(clk_tb),
	.rst_n		(rst_n),
	.clk_out 	(clk2Hz_tb)
);

Counter16 count
(
	.clk 	   	(clk2Hz_tb),
	.rst_n		(rst_n),
	.count 		(BCD_tb)
);
	
endmodule 