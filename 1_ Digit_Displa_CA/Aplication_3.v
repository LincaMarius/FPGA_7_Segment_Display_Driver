
// Aplicațion for testing
// Hexadecimal to one Digit 7-Segment Display FPGA Driver

module Aplication_3 (
	input clk50MHz, // Main clock 50 MHz
	input rst_n, // Reset button
	output [6:0] Segments, // Cathode segments control outputs 
	output dp, // DP on Piswords PIAX301V2 FPGA board control output
	output SEL7 // SEL7 on Piswords PIAX301V2 FPGA board control output
);	

// signals for connection between modules
wire clk2Hz;
wire [3:0] HEX_data;	

// we declare the components
HEX_to_1_Digit_CA decoder
(
	.HEX_in		(HEX_data),
	.dp_in		(HEX_data[0]),
	.Segments 	(Segments),
	.dp			(dp),
	.SEL7			(SEL7)
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
	.count 		(HEX_data)
);
	
endmodule