//simple adder

module PC_add(
	input wire[31:0] arg_1,
	output reg[31:0] result
);


always @* begin
	result <=  arg_1 + 1;

end

endmodule
