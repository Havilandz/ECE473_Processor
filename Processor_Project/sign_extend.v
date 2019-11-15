//Sign Extender for ECE473 final project
module sign_extend(
	input wire [15:0] in,
	output reg [31:0] out);

	reg signed [31:0]temp;

	always @(*) begin
		temp[31:16] <= in;
		out <= temp >>> 16;
	
	
	end
endmodule
