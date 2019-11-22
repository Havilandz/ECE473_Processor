//A single register

module EX_MEM(
	// WB control
	input wire RegWrite_in,
	input wire MemtoReg_in,
	output reg RegWrite_out,
	output reg MemtoReg_out,
	//Memory control
	input wire MemRead_in,
	input wire MemWrite_in,
	input wire [3:0]PCsrc_in,
	output reg MemRead_out,
	output reg MemWrite_out,
	output reg [3:0]PCsrc_out,

	
	
	//data registers
    input wire [31:0] data_in_1,
    output reg [31:0] data_out_1,
	input wire zero_in,
	output reg zero_out,
	input wire [31:0] ALU_result_in,
    output reg [31:0] ALU_result_out,
	input wire [31:0] PC_in,
	output reg [31:0] PC_out,
	input wire [4:0] Dest_Reg_Addr_in,
    output reg [4:0] Dest_Reg_Addr_out,
	
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
			zero_out <= 0;

		
			//clear data
            data_out_1 <= 32'h0;
			ALU_result_out <= 32'h0;
			Dest_Reg_Addr_out <= 32'h0;
			PC_out <=0;
        end else if (write == 1'b1) begin
			RegWrite_out <=RegWrite_in;
			MemtoReg_out <=MemtoReg_in;
			MemRead_out <=MemRead_in;
			MemWrite_out <=MemWrite_in;
			PCsrc_out <=PCsrc_in;

		
            data_out_1 <= data_in_1;
			ALU_result_out <= ALU_result_in;
			Dest_Reg_Addr_out <= Dest_Reg_Addr_in;
			zero_out <= zero_in;
			PC_out<=PC_in;
        end else begin
		
			RegWrite_out <=RegWrite_out;
			MemtoReg_out <=MemtoReg_out;
			MemRead_out <=MemRead_out;
			MemWrite_out <=MemWrite_out;
			PCsrc_out <=PCsrc_out;

			
			
            data_out_1 <= data_out_1;
			ALU_result_out <= ALU_result_out;
			Dest_Reg_Addr_out <= Dest_Reg_Addr_out;
			zero_out <= zero_in;
			PC_out<=PC_out;
        end
    end

endmodule
