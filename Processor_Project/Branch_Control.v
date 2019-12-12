/*

Five Stage Pipeline Branch ALU

Zach Haviland

Five stage pipeline aritmetic logic unit used to execute logic
*/

module Branch_Control(
	input wire [31:0] arg1, //RS
	input wire [31:0]  arg2, //RD or RT or immediate value depending on the instruction
	input wire[4:0] ALU_op,
	input wire[25:0] j_addr, 
	output reg result,
	output reg [31:0] j_addr_extend
	
	



);

reg signed [31:0] temp;
reg signed [31:0] branch_temp;
	/*
	Branch control opcode table
	bne : 01010
	bgtz: 01011
	bgez: 01100
	beq : 01101
	*/
	always @(*) begin
		branch_temp <= arg1;
		case(ALU_op)
			default  : result <= 0; //things that are not branch instructions
			5'b01101 : result <= (arg1 == arg2) ? 1:0; //beq
			5'b01010 : result <= (arg1 != arg2) ? 1:0;//bne
			5'b01011 : result <= (branch_temp > 0) ? 1:0;//bgtz
			5'b01100 : result <= (branch_temp >= 0) ? 1:0;//bgez
			
		endcase
		temp[31:7] <= j_addr;
		j_addr_extend <= temp >>> 7;
		
	end

	
	
endmodule
