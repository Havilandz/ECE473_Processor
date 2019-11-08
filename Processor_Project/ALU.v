/*

Five stage pipeline ALU

Zach Haviland

Five stage pipeline aritmetic logic unit used to execute logic
*/

module ALU(
	input wire[31:0] arg1, //RS
	input wire[31:0] arg2, //RD or RT depending on the instruction
	input wire[4:0] ALU_op,
	input wire[4:0] shamt, 
	
	output reg zero,
	output reg[31:0] result



);






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
	*/
	always @(*) begin
		case(ALU_op)
			5'b00000 : result <= arg1+arg2;//add(arg1, arg2, result); 
			5'b00001 : sub();
			5'b00010 : instr_and();
			5'b00011 : instr_or();
			5'b00100 : instr_nor();
			5'b00101 : sll();
			5'b00110 : srl();
			5'b00111 : sra();
			5'b01000 : slt();
		endcase
	end

	task add();
		begin
			result <= arg1 + arg2;
			if(result == 0) begin
				zero<=1;
			end else begin
				zero <= 0;
			end		
		end
	endtask
	
	task sub();
		begin
			result <= arg1- arg2;
			if(result == 0) begin
				zero<=1;
			end else begin
				zero <= 0;
			end		
		end
	endtask

	task instr_and();
		begin
			result <= arg1&arg2;
			if(result ==0) begin
				zero<=1;
			end else begin
				zero <= 0;
			end		
		end
	endtask

	task instr_or();
		begin
			result <= arg1|arg2;
			if(result == 0) begin
				zero<=1;
			end else begin
				zero <= 0;
			end		
		end
	endtask
	
	task instr_nor();
		begin
			result <= ~(arg1|arg2);
			
			if(result ==0) begin
				zero<=1;
			end else begin
				zero <= 0;
			end		
		end
	endtask
	
	task sll();
		begin
			result <= arg2<<shamt;//shifted by shamt might need to make them the same width...
			if(result ==0) begin
				zero<=1;
			end else begin
				zero <= 0;
			end		
		end
	endtask
	
	task srl();
		begin
			result <= arg2>>shamt;//shifted by shamt might need to make them the same width...
			if(result ==0) begin
				zero<=1;
			end else begin
				zero <= 0;
			end		
		end
	endtask
	
	task sra();
		begin
			result <= arg2>>>shamt;//shifted by shamt might need to make them the same width...
			if(result ==0) begin
				zero<=1;
			end else begin
				zero <= 0;
			end		
		end
	endtask

	task slt();
		begin
			if(arg1 > arg2) begin
				result <= 1;
			end else begin
				result <= 0;
			end
			if(result == 0) begin
				zero<=1;
			end else begin
				zero <= 0;
			end		
		end
	endtask
endmodule
