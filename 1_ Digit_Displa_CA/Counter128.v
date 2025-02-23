

// counter 7 bits

module Counter128 (
	input clk,
	input rst_n,
	output[6:0] count
);

reg[6:0] timer;

always@(posedge clk or negedge rst_n)
begin
	if (rst_n == 1'b0)
			timer <= 7'd0;
	else if (timer == 7'd128) 
			timer <= 7'd0;	
	else  			
		timer <= timer + 7'd1; 					
end

assign count = timer;

endmodule