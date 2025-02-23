`timescale 1ns/1ns

// Verilog code for test bench fot ASCII to one Digit 7-Segment Display FPGA Driver

module ASCII_to_1_Digit_CC_tb;

// input signals of the mode under test
wire[6:0] ASCII_tb;

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
HEX_to_1_Digit_CC dut
(
	.ASCII_in	(ASCII_tb),
	.dp_in		(ASCII_tb[0]),
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

Counter128 count
(
	.clk 	   	(clk2Hz_tb),
	.rst_n		(rst_n),
	.count 		(ASCI_tb)
);
	
endmodule 