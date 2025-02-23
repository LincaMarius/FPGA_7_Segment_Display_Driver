
// Verilog code for BCD to one Digit 7-Segment Common Anode Display FPGA Driver

module HEX_to_1_Digit_CA (
	input [3:0] HEX_in,
	input dp_in,
	output reg [6:0] Segments,
	output dp,
	output SEL7
	);

always @(*)
begin
	case(HEX_in)
						  	  // gfedcba - active low
		4'd0: Segments = 7'b1000000; // 0, active a,b,c,d,e,f segments
		4'd1: Segments = 7'b1111001; // 1, active b,c segments
		4'd2: Segments = 7'b0100100; // 2, active a,b,d,e,g segments
		4'd3: Segments = 7'b0110000; // 3, active a,b,c,d,g segments
		4'd4: Segments = 7'b0011001; // 4, active b,c,f,g segments
		4'd5: Segments = 7'b0010010; // 5, active a,c,d,f,g segments
		4'd6: Segments = 7'b0000010; // 6, active a,c,d,e,f,g segments
		4'd7: Segments = 7'b1111000; // 7, active a,b,c segments
		4'd8: Segments = 7'b0000000; // 8, active a,b,c,d,e,f,g segments
		4'd9: Segments = 7'b0010000; // 9, active a,b,c,d,e,g segments
		4'd10: Segments = 7'b0001000; // A, active a,b,c,e,f,g segments
		4'd11: Segments = 7'b0000011; // b, active c,d,e,f,g segments	
		4'd12: Segments = 7'b1000110; // C, active a,d,e,f segments	
		4'd13: Segments = 7'b0100001; // d, active b,c,d,e,g segments		
		4'd14: Segments = 7'b0000110; // E, active a,d,e,f,g segments				
		4'd15: Segments = 7'b0001110; // F, active a,e,f,g segments	
		default: Segments = 8'b1111111; // default blank
	endcase
end

	assign SEL7 = 0;
	assign dp = dp_in;	

endmodule