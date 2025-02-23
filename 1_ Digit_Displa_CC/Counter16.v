

// counter 4 bits

module Counter16 (
	input clk,
	input rst_n,
	output[3:0] count
);

reg[3:0] timer;

always@(posedge clk or negedge rst_n)
begin
	if (rst_n == 1'b0)
			timer <= 16'd0;
	else if (timer == 16'd15) 
			timer <= 16'd0;	
	else  			
		timer <= timer + 16'd1; 					
end

assign count = timer;

endmodule