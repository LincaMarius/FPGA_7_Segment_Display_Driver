
// Aplicațion for testing
// BCD to one Digit 7-Segment Common Cathode Display FPGA Driver

module Aplication_2 (
	input clk50MHz, // Main clock 50 MHz
	input rst_n, // Reset button
	output [6:0] Segments, // Cathode segments control outputs 
	output dp // DP on Piswords PIAX301V2 FPGA board control output
);	

// signals for connection between modules
wire clk2Hz;
wire [3:0] BCD_data;	

// we declare the components
BCD_to_1_Digit_CC decoder
(
	.BCD_in		(BCD_data),
	.dp_in		(BCD_data[0]),
	.Segments 	(Segments),
	.dp			(dp)
);

Clk_2Hz clk_2Hz
(
	.clk_in 		(clk50MHz),
	.rst_n		(rst_n),
	.clk_out 	(clk2Hz)
);

Counter16 count
(
	.clk 	   	(clk2Hz),
	.rst_n		(rst_n),
	.count 		(BCD_data)
);
	
endmodule