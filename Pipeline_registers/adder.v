// A simple adder

module adder(
	input wire [31:0] input_a,
	input wire [31:0] input_b,
	output reg [31:0] result);

	always @(*) begin
	result <= input_a + input_b;

	end

endmodule