
// Verilog code for BCD to one Digit 7-Segment Common Anode Display FPGA Driver

module ASCII_to_1_Digit_CA (
	input [6:0] ASCII_in,
	input dp_in,
	output reg [6:0] Segments,
	output dp,
	output SEL7
	);

always @(*)
begin
	case(ASCII_in)
								// gfedcba - active low
		7'h00: Segments = 7'b1000000; // 0, active a,b,c,d,e,f segments
		7'h01: Segments = 7'b1111001; // 1, active b,c segments
		7'h02: Segments = 7'b0100100; // 2, active a,b,d,e,g segments
		7'h03: Segments = 7'b0110000; // 3, active a,b,c,d,g segments
		7'h04: Segments = 7'b0011001; // 4, active b,c,f,g segments
		7'h05: Segments = 7'b0010010; // 5, active a,c,d,f,g segments		
		7'h06: Segments = 7'b0000010; // 6, active a,c,d,e,f,g segments		
		7'h07: Segments = 7'b1111000; // 7, active a,b,c segments			
		7'h08: Segments = 7'b0000000; // 8, active a,b,c,d,e,f,g segments		
		7'h09: Segments = 7'b0010000; // 9, active a,b,c,d,f,g segments		
		7'h0A: Segments = 7'b0001000; // A, active a,b,c,e,f,g segments			
		7'h0B: Segments = 7'b0000011; // b, active c,d,e,f,g segments	
		7'h0C: Segments = 7'b1000110; // C, active a,d,e,f segments	
		7'h0D: Segments = 7'b0100001; // d, active b,c,d,e,g segments	
		7'h0E: Segments = 7'b0000110; // E, active a,d,e,f,g segments			
		7'h0F: Segments = 7'b0001110; // F, active a,e,f,g segments							      
		7'h20: Segments = 7'b1111111; // Space, blank				
		7'h21: Segments = 7'b1111001; // !, active b,c segments									  					  
		7'h22: Segments = 7'b1011101; // ", active b,f segments											 
		7'h27: Segments = 7'b1011111; // ', active f segment								 
		7'h28: Segments = 7'b1010110; // (, active a,d,f segments											 				 
		7'h29: Segments = 7'b1110100; // ), active a,b,d segments					     
		7'h2A: Segments = 7'b1011110; // *, active a,f segments
		7'h2B: Segments = 7'b0001111; // +, active e,f,g segments
		7'h2C: Segments = 7'b1101111; // ,, active e segment
		7'h2D: Segments = 7'b0111111; // -, active g segment
		7'h2F: Segments = 7'b0101101; // /, active b,e,g segment
		7'h30: Segments = 7'b1000000; // 0, active a,b,c,d,e,f segments
		7'h31: Segments = 7'b1111001; // 1, active b,c segments
		7'h32: Segments = 7'b0100100; // 2, active a,b,d,e,g segments							  				 
		7'h33: Segments = 7'b0110000; // 3, active a,b,c,d,g segments								
		7'h34: Segments = 7'b0011001; // 4, active b,c,f,g segments											  
		7'h35: Segments = 7'b0010010; // 5, active a,c,d,f,g segments			
		7'h36: Segments = 7'b0000010; // 6, active a,c,d,e,f,g segments 	
		7'h37: Segments = 7'b1011000; // 7, active a,b,c,f segments 
		7'h38: Segments = 7'b0000000; // 8, active a,b,c,d,e,f,g segments
		7'h39: Segments = 7'b0010000; // 9, active a,b,c,d,f,g segments
		7'h3C: Segments = 7'b1100111; // <, active d,e segments
		7'h3D: Segments = 7'b0110111; // =, active d,g segments
		7'h3E: Segments = 7'b1110011; // >, active c,d segments
		7'h3F: Segments = 7'b0101100; // ?, active a,b,e,g segments
		7'h40: Segments = 7'b0100000; // @, active a,b,c,d,e,g segments
		7'h41: Segments = 7'b0001000; // A, active a,b,c,e,f,g segments
		7'h42: Segments = 7'b0000011; // b, active c,d,e,f,g segments
		7'h43: Segments = 7'b1000110; // C, active a,d,e,f segments		
		7'h44: Segments = 7'b0100001; // d, active b,c,d,e,g segments	
		7'h45: Segments = 7'b0000110; // E, active a,d,e,f,g segments						  
		7'h46: Segments = 7'b0001110; // F, active a,e,f,g segments					   
		7'h47: Segments = 7'b1000010; // G, active a,c,d,e,f segments			
		7'h48: Segments = 7'b0001001; // H, active b,c,e,f,g segments						   
		7'h49: Segments = 7'b1001111; // I, active e,f segments						  
		7'h4A: Segments = 7'b1100001; // J, active b,c,d,e segments						
		7'h4B: Segments = 7'b0001010; // K, active a,c,e,f,g segments						
		7'h4C: Segments = 7'b1000111; // L, active d,e,f segments					
		7'h4D: Segments = 7'b1101010; // m, active a,c,e segments					
		7'h4D: Segments = 7'b1001000; // N, active a,b,c,e,f segments							
		7'h4F: Segments = 7'b0100011; // o, active c,d,e,g segments							
		7'h50: Segments = 7'b0001100; // P, active a,b,e,f,g segments						
		7'h51: Segments = 7'b0011000; // q, active a,b,c,f,g segments							
		7'h52: Segments = 7'b1001100; // R, active a,b,e,f segments						
		7'h53: Segments = 7'b0010010; // S, active a,c,d,f,g segments							
		7'h54: Segments = 7'b0000111; // t, active d,e,f,g segments						
		7'h55: Segments = 7'b1000001; // U, active b,c,d,e,f segments						
		7'h56: Segments = 7'b1000101; // V, active b,d,e,f segments							
		7'h57: Segments = 7'b1010101; // W, active b,d,f segments						
		7'h59: Segments = 7'b0010001; // Y, active b,c,d,f,g segments						
		7'h5C: Segments = 7'b0011011; // \, active c,f,g segments							
		7'h5E: Segments = 7'b1011100; // ^, active a,b,f segments							
		7'h5F: Segments = 7'b1110111; // _, active d segment							
		7'h60: Segments = 7'b1111101; // `, active b segment							
		7'h61: Segments = 7'b0100000; // a, active a,b,c,d,e,g segments							
		7'h62: Segments = 7'b0000011; // b, active c,d,e,f,g segments			
		7'h63: Segments = 7'b0100111; // c, active d,e,g segments							
		7'h64: Segments = 7'b0100001; // d, active b,c,d,e,g segments						
		7'h65: Segments = 7'b0000100; // e, active a,b,d,e,f,g segments							
		7'h66: Segments = 7'b0001110; // F, active a,e,f,g segments
		7'h67: Segments = 7'b1000010; // G, active a,c,d,e,f segments						
		7'h68: Segments = 7'b0001011; // h, active c,e,f,g segments							
		7'h69: Segments = 7'b1001111; // I, active e,f segments							
		7'h6A: Segments = 7'b1100001; // J, active b,c,d,e segments						
		7'h6B: Segments = 7'b0001010; // K, active a,c,e,f,g segments							
		7'h6C: Segments = 7'b1000111; // L, active d,e,f segments						
		7'h6D: Segments = 7'b1101011; // m, active c,e segments							
		7'h6E: Segments = 7'b0101011; // n, active c,e,g segments						
		7'h6F: Segments = 7'b0100011; // o, active c,d,e,g segments						
		7'h70: Segments = 7'b0001100; // P, active a,b,e,f,g segments							
		7'h71: Segments = 7'b0011000; // q, active a,b,c,f,g segments							
		7'h72: Segments = 7'b0101111; // r, active e,g segments							
		7'h73: Segments = 7'b0010010; // S, active a,c,d,f,g segments							
		7'h74: Segments = 7'b0000111; // t, active d,e,f,g segments					
		7'h75: Segments = 7'b1100011; // u, active c,d,e segments						
		7'h79: Segments = 7'b0010001; // Y, active b,c,d,f,g segments								
		7'h7E: Segments = 7'b1111110; // ~, active a segment						
			default: Segments = 7'b1111111; // default blank
	endcase
end

	assign SEL7 = 0;
	assign dp = dp_in;	

endmodule