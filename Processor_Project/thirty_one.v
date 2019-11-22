

module thirty_one(
output reg [4:0] thirty_one
);
	
	always @(*) begin
		thirty_one <= (4'h0 | 31);
	end
	
endmodule
