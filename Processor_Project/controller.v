/* 
5 stage pipeline controller

Zach Haviland
This is the control module for the five stage pipeline
project.

*/

module controller(//need to specify how big these are
	input wire [5:0] opcode,
	input wire [5:0] funcode,
	
	output reg RegWrite,
	output reg MemtoReg,
	output reg MemRead,
	output reg MemWrite,
	output reg[1:0] PCsrc, 
	output reg RegDst,
	output reg[4:0] ALUop,
	output reg ALUsrc
	);

	

//Main code
	always @(*) begin
		case(opcode)
			6'b000000 : r_type(funcode);
			6'b001100 : andi();
			6'b001101 : ori();
			6'b001010 : slti();
			6'b001000 : addi();
			6'b001001 : addi(); //addiu, same as addi in hardware
			6'b000100 : beq();
			6'b000101 : bne();
			6'b000111 : bgtz();
			6'b000001 : bgez();
			6'b100011 : lw();
			6'b101011 : sw();
			6'b001111 : lui();
		
		endcase	
	end



	
//r_type function routine
	task r_type(input[5:0] funcode);
		begin
			case(funcode)
				//function_code: do thing
				6'b100000 : add();
				6'b100001 : add(); //addu. Same as add in hardware
				6'b100010 : sub();
				6'b100011 : sub(); //subu. same as sub in hardware
				6'b100100 : instr_and();
				6'b100101 : instr_or();
				6'b100111 : instr_nor();
				6'b101010 : slt(); //set less than
				6'b000000 : sll(); //shift left logical
				6'b000010 : srl(); //shift right logical
				6'b000011 : sra(); //shift right arithmatic
				6'b001000 : jr(); //jump to address in register
				
				
			
				default : sll();
			endcase
		end
	endtask
	
	
	
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
	
	//Add instruction
	task add();
		begin
			RegWrite <= 1; //write to register file
			MemtoReg <= 0; //write from data memory
			MemRead <= 0; //read data memory
			MemWrite <= 0; //write to data memory
			PCsrc <= 2'b00; 
			RegDst <= 0; //0 for RD to be destination 1 for RT
			ALUop <= 5'b00000; //ALU adds
			ALUsrc <= 0; //1 for I type instructions, except branches
		end
	endtask
	
	
	task sub();
		begin
			RegWrite <= 1; //write to register file
			MemtoReg <= 0; //write from data memory
			MemRead <= 0; //read data memory
			MemWrite <= 0; //write to data memory
			PCsrc <= 2'b00; 
			RegDst <= 0; //0 for RD to be destination 1 for RT
			ALUop <= 5'b00001; //ALU subtracts
			ALUsrc <= 0; //1 for I type instructions, except branches
		end
	endtask
	
	
	task instr_and();
		begin
			RegWrite <= 1; //write to register file
			MemtoReg <= 0; //write from data memory
			MemRead <= 0; //read data memory
			MemWrite <= 0; //write to data memory
			PCsrc <= 2'b00; //PCsrc?
			RegDst <= 0; //0 for RD to be destination 1 for RT
			ALUop <= 5'b00010; 
			ALUsrc <= 0; //1 for I type instructions, except branches
		end
	endtask
	
	task instr_or();
		begin
			RegWrite <= 1; //write to register file
			MemtoReg <= 0; //write from data memory
			MemRead <= 0; //read data memory
			MemWrite <= 0; //write to data memory
			PCsrc <= 2'b00; //PCsrc?
			RegDst <= 0; //0 for RD to be destination 1 for RT
			ALUop <= 5'b00011; //ALU ors
			ALUsrc <= 0; //1 for I type instructions, except branches
		end
	endtask
	
	task instr_nor();
		begin
			RegWrite <= 1; //write to register file
			MemtoReg <= 0; //write from data memory
			MemRead <= 0; //read data memory
			MemWrite <= 0; //write to data memory
			PCsrc <= 2'b00; //PCsrc?
			RegDst <= 0; //0 for RD to be destination 1 for RT
			ALUop <= 5'b00100;
			ALUsrc <= 0; //1 for I type instructions, except branches
		end
	endtask
	
	task slt();
		begin
			RegWrite <= 1; //write to register file
			MemtoReg <= 0; //write from data memory
			MemRead <= 0; //read data memory
			MemWrite <= 0; //write to data memory
			PCsrc <= 2'b00; //PCsrc?
			RegDst <= 0; //0 for RD to be destination 1 for RT
			ALUop <= 5'b01000; 
			ALUsrc <= 0; //1 for I type instructions, except branches
		end
	endtask
	
	task sll();
		begin
			RegWrite <= 1; //write to register file
			MemtoReg <= 0; //write from data memory
			MemRead <= 0; //read data memory
			MemWrite <= 0; //write to data memory
			PCsrc <= 2'b00; //PCsrc?
			RegDst <= 0; //0 for RD to be destination 1 for RT
			ALUop <= 5'b00101;
			ALUsrc <= 0; //1 for I type instructions, except branches
		end
	endtask
	
	task srl();
		begin
			RegWrite <= 1; //write to register file
			MemtoReg <= 0; //write from data memory
			MemRead <= 0; //read data memory
			MemWrite <= 0; //write to data memory
			PCsrc <= 2'b00; //PCsrc?
			RegDst <= 0; //0 for RD to be destination 1 for RT
			ALUop <= 5'b00110;
			ALUsrc <= 0; //1 for I type instructions, except branches
		end
	endtask
	
	task sra();
		begin
			RegWrite <= 1; //write to register file
			MemtoReg <= 0; //write from data memory
			MemRead <= 0; //read data memory
			MemWrite <= 0; //write to data memory
			PCsrc <= 2'b00; //PCsrc?
			RegDst <= 0; //0 for RD to be destination 1 for RT.  for I type instructions
			ALUop <= 5'b00111;
			ALUsrc <= 0; //1 for I type instructions, except branches
		end
	endtask
	
	task jr();
		begin
			RegWrite <= 0;
			MemtoReg <= 0;
			MemRead <= 0;
			MemWrite <= 0;
			PCsrc <= 2'b01;
			RegDst <= 0;
			ALUop <= 2'b00101;
			ALUsrc <= 0;
		end
	endtask
	
	//I type tasks
	
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
	task andi();
		begin
			RegWrite <= 1; //write to register file
			MemtoReg <= 0; //write from data memory
			MemRead <= 0; //read data memory
			MemWrite <= 0; //write to data memory
			PCsrc <= 2'b00; //PCsrc?
			RegDst <= 1; //0 for RD to be destination 1 for RT
			ALUop <= 5'b00010; 
			ALUsrc <= 1; //1 for I type instructions, except branches	
		end
	endtask
	task ori();
		begin
			RegWrite <= 1; //write to register file
			MemtoReg <= 0; //write from data memory
			MemRead <= 0; //read data memory
			MemWrite <= 0; //write to data memory
			PCsrc <= 2'b00; //PCsrc?
			RegDst <= 1; //0 for RD to be destination 1 for RT
			ALUop <= 5'b00011; //ALU alu or
			ALUsrc <= 1; //1 for I type instructions, except branches
		end
	endtask
	task slti();
		begin
			RegWrite <= 1; //write to register file
			MemtoReg <= 0; //write from data memory
			MemRead <= 0; //read data memory
			MemWrite <= 0; //write to data memory
			PCsrc <= 2'b00; //PCsrc?
			RegDst <= 1; //0 for RD to be destination 1 for RT
			ALUop <= 5'b01000; //alu slts
			ALUsrc <= 1; //1 for I type instructions, except branches
		end
	endtask
	task addi();
		begin
			RegWrite <= 1; //write to register file
			MemtoReg <= 0; //write from data memory
			MemRead <= 0; //read data memory
			MemWrite <= 0; //write to data memory
			PCsrc <= 2'b00; 
			RegDst <= 1; //0 for RD to be destination 1 for RT
			ALUop <= 5'b00000; //ALU adds
			ALUsrc <= 1; //1 for I type instructions, except branches
		end
	endtask
	task beq();
		begin
			RegWrite <= 0; //write to register file
			MemtoReg <= 0; //write from data memory
			MemRead <= 0; //read data memory
			MemWrite <= 0; //write to data memory
			PCsrc <= 2'b10; //10 for branch
			RegDst <= 0; //0 for RD to be destination 1 for RT
			ALUop <= 5'b00001; //ALU sub
			ALUsrc <= 0; //1 for I type instructions, except branches
		end
	endtask
	
	/*	
	bne : 01010
	bgtz: 01011
	bgez: 01100
	*/
	task bne();
		begin
			RegWrite <= 0; //write to register file
			MemtoReg <= 0; //write from data memory
			MemRead <= 0; //read data memory
			MemWrite <= 0; //write to data memory
			PCsrc <= 2'b10; //10 for branch
			RegDst <= 0; //0 for RD to be destination 1 for RT
			ALUop <= 5'b01010; //ALU bne
			ALUsrc <= 0; //1 for I type instructions, except branches
		end
	endtask
	task bgtz();
		begin
			RegWrite <= 0; //write to register file
			MemtoReg <= 0; //write from data memory
			MemRead <= 0; //read data memory
			MemWrite <= 0; //write to data memory
			PCsrc <= 2'b10; //10 for branch
			RegDst <= 0; //0 for RD to be destination 1 for RT
			ALUop <= 5'b01011; //ALU bgtz
			ALUsrc <= 0; //1 for I type instructions, except branches
		end
	endtask
	task bgez();
		begin
			RegWrite <= 0; //write to register file
			MemtoReg <= 0; //write from data memory
			MemRead <= 0; //read data memory
			MemWrite <= 0; //write to data memory
			PCsrc <= 2'b10; //10 for branch
			RegDst <= 0; //0 for RD to be destination 1 for RT
			ALUop <= 5'b01100; //ALU bgez
			ALUsrc <= 0; //1 for I type instructions, except branches
		end
	endtask
	task lw();
		begin
			RegWrite <= 1; //write to register file
			MemtoReg <= 1; //write from data memory
			MemRead <= 1; //read data memory
			MemWrite <= 0; //write to data memory
			PCsrc <= 2'b00; 
			RegDst <= 1; //0 for RD to be destination 1 for RT
			ALUop <= 5'b00000; //ALU adds
			ALUsrc <= 1; //1 for I type instructions, except branches
		end
	endtask
	task sw();
		begin
			RegWrite <= 0; //write to register file
			MemtoReg <= 0; //write from data memory
			MemRead <= 0; //read data memory
			MemWrite <= 1; //write to data memory
			PCsrc <= 2'b00; 
			RegDst <= 1; //0 for RD to be destination 1 for RT
			ALUop <= 5'b00000; //ALU adds
			ALUsrc <= 1; //1 for I type instructions, except branches
		end
	endtask
	task lui();
		begin
			RegWrite <= 1; //write to register file
			MemtoReg <= 0; //write from data memory
			MemRead <= 0; //read data memory
			MemWrite <= 0; //write to data memory
			PCsrc <= 2'b00; 
			RegDst <= 1; //0 for RD to be destination 1 for RT
			ALUop <= 5'b01001; //ALU lui
			ALUsrc <= 1; //1 for I type instructions, except branches
		end
	endtask

	
	
endmodule
