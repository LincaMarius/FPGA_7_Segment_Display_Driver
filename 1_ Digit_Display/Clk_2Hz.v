
// frequency divider from 50 MHz to 2 Hz

module Clk_2Hz (
	input clk_in,
	input rst_n,
	output clk_out
);

reg clk = 1'b0;
reg [24:0] timer;

always@(posedge clk or negedge rst_n)
begin
	if (rst_n == 1'b0)
		begin
			timer <= 32'd0;
			clk <= 1'b0;
		end
	else if (timer == 25'd25_000_000) 
		begin
			timer <= 32'd0;
			clk <= ~clk;
		end	
	else  			
		timer <= timer + 32'd1; 					
end

endmodule
