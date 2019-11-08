//A single register

module ID_EX(
	// WB control
	input wire RegWrite_in,
	input wire MemtoReg_in,
	output reg RegWrite_out,
	output reg MemtoReg_out,
	//Memory control
	input wire MemRead_in,
	input wire MemWrite_in,
	input wire [1:0]PCsrc_in,
	output reg MemRead_out,
	output reg MemWrite_out,
	output reg [1:0]PCsrc_out,
	//Ex control
	input wire RegDst_in,
	input wire [4:0] ALUop_in,
	input wire ALUsrc_in,
	output reg RegDst_out,
	output reg[4:0] ALUop_out,
	output reg ALUsrc_out,

	
	
	//data registers
    input wire [31:0] data_in_1,
    output reg [31:0] data_out_1,
	input wire [31:0] data_in_2,
    output reg [31:0] data_out_2,
	input wire [4:0] RD_in,
    output reg [4:0] RD_out,
	input wire [4:0] RT_in, 
	output reg [4:0] RT_out,
	input wire [4:0] shamt_in,
	output reg [4:0] shamt_out,
	
	
	//register controll
    input wire reset,
    input wire write,
	input wire clock);

    always @(posedge clock) begin
        if (reset == 1'b1) begin //clears register
			//clear control signals
			RegWrite_out <=0;
			MemtoReg_out <=0;
			MemRead_out <=0;
			MemWrite_out <=0;
			PCsrc_out <=0;
			RegDst_out <= 0;
			ALUop_out <= 2'h0;
			ALUsrc_out <=0;
		
			//clear data
            data_out_1 <= 32'h0;
			data_out_2 <= 32'h0;
			RD_out <= 5'h0;
			RT_out <= 5'h0;
			shamt_out <= 0;
        end else if (write == 1'b1) begin
			RegWrite_out <=RegWrite_in;
			MemtoReg_out <=MemtoReg_in;
			MemRead_out <=MemRead_in;
			MemWrite_out <=MemWrite_in;
			PCsrc_out <=PCsrc_in;
			RegDst_out <= RegDst_in;
			ALUop_out <= ALUop_in;
			ALUsrc_out <=ALUsrc_in;
		
            data_out_1 <= data_in_1;
			data_out_2 <= data_in_2;
			RD_out <= RD_in;
			RT_out <= RT_in;
			shamt_out <= shamt_in;
        end else begin
		
			RegWrite_out <=RegWrite_out;
			MemtoReg_out <=MemtoReg_out;
			MemRead_out <=MemRead_out;
			MemWrite_out <=MemWrite_out;
			PCsrc_out <=PCsrc_out;
			RegDst_out <= RegDst_out;
			ALUop_out <= ALUop_out;
			ALUsrc_out <=ALUsrc_out;
			
			
            data_out_1 <= data_out_1;
			data_out_2 <= data_out_2;
			RD_out <= RD_out;
			RT_out <= RT_out;
			shamt_out <= shamt_out;
        end
    end

endmodule
