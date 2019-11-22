//simple adder

module branch_add(
	input wire[31:0] arg_1,
	input wire[31:0] arg_2,
	output reg[31:0] result
);

//doens't bitshift because we are word addressable
always @* begin
	result <=  arg_1 + (arg_2);

end

endmodule
