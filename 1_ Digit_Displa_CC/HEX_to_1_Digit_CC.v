
// Verilog code for BCD to one Digit 7-Segment Common Anode Display FPGA Driver

module HEX_to_1_Digit_CC (
	input [3:0] HEX_in,
	input dp_in,
	output reg [6:0] Segments,
	output dp,
	output SEL7
	);

always @(*)
begin
	case(HEX_in)
						  	  // gfedcba - active High
		4'd0: Segments = 7'b0111111; // 0, active a,b,c,d,e,f segments
		4'd1: Segments = 7'b0000110; // 1, active b,c segments
		4'd2: Segments = 7'b1011011; // 2, active a,b,d,e,g segments
		4'd3: Segments = 7'b1001111; // 3, active a,b,c,d,g segments
		4'd4: Segments = 7'b1100110; // 4, active b,c,f,g segments
		4'd5: Segments = 7'b1101101; // 5, active a,c,d,f,g segments
		4'd6: Segments = 7'b1111101; // 6, active a,c,d,e,f,g segments
		4'd7: Segments = 7'b0000111; // 7, active a,b,c segments
		4'd8: Segments = 7'b1111111; // 8, active a,b,c,d,e,f,g segments
		4'd9: Segments = 7'b1101111; // 9, active a,b,c,d,e,g segments
		4'd10: Segments = 7'b1110111; // A, active a,b,c,e,f,g segments
		4'd11: Segments = 7'b1111100; // b, active c,d,e,f,g segments	
		4'd12: Segments = 7'b0111001; // C, active a,d,e,f segments	
		4'd13: Segments = 7'b1011110; // d, active b,c,d,e,g segments	
		4'd14: Segments = 7'b1111001; // E, active a,d,e,f,g segments	
		4'd15: Segments = 7'b1110001; // F, active a,e,f,g segments	
		default: Segments = 8'b0000000; // default blank
	endcase
end

	assign SEL7 = 0;
	assign dp = dp_in;	

endmodule