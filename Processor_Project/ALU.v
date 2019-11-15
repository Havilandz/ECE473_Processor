/*

Five stage pipeline ALU

Zach Haviland

Five stage pipeline aritmetic logic unit used to execute logic
*/

module ALU(
	input wire [31:0] arg1, //RS
	input wire [31:0]  arg2, //RD or RT or immediate value depending on the instruction
	input wire[4:0] ALU_op,
	input wire[4:0] shamt, 
	
	output reg zero,
	output reg[31:0] result



);




	reg signed[31:0] temp;

	/*
	ALU opcode table
	add : 00000
	sub : 00001
	and : 00010
	or  : 00011
	nor : 00100
	sll : 00101
	srl : 00110
	sra : 00111
	slt : 01000
	lui : 01001
	bne : 01010
	bgtz: 01011
	bgez: 01100
	*/
	always @(*) begin
		case(ALU_op)
			5'b00000 : result <= arg1+arg2;//add; 
			5'b00001 : result <= arg1-arg2; //sub
			5'b00010 : result <= arg1&arg2; //and
			5'b00011 : result <= (arg1|arg2); //or
			5'b00100 : result <= ~(arg1|arg2); //nor
			5'b00101 : result <= arg2<<shamt; //sll
			5'b00110 : result <= arg2>>shamt; //srl
			5'b00111 : sra();
			5'b01000 : slt();
			5'b01001 : result <= arg2<<16; //lui()
			5'b01010 : result <= (arg1 != arg2) ? 0:1;//bne
			5'b01011 : result <= (arg1 > 0) ? 0:1;//bgtz
			5'b01100 : result <= (arg1 >= 0) ? 0:1;//bgez
		endcase
		if(result == 0) begin
				zero<=1;
		end else begin
				zero <= 0;
		end	
	end

	
	task sra();
		begin
			temp <= arg2;
			result <= temp>>>shamt;	
		end
	endtask

	task slt();
		begin
			if(arg1 > arg2) begin
				result <= 1;
			end else begin
				result <= 0;
			end	
		end
	endtask
	
endmodule
