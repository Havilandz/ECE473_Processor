//Forwarding Controller for 5 stage mips pipeline processor


module branch_forward_unit(
	input wire [4:0] ID_EX_RD,
	input wire [4:0] EX_MEM_RD,
	input wire [4:0] MEM_WB_RD,
	input wire ID_EX_RegWrite,
	input wire EX_MEM_RegWrite,
	input wire MEM_WB_RegWrite,
	input wire [4:0] RS,
	input wire [4:0] RT,
	
	output reg [1:0] FwdCtrl_1,
	output reg [1:0] FwdCtrl_2 
);

	/*Forward control notes 
		for fwdctrl 1/2
		01: grab value from ex/mem register
		10: grab value from mem_mux	
	*/
	
	
	always @(*) begin
		if((ID_EX_RD == RS) && (ID_EX_RegWrite == 1)) begin
			FwdCtrl_1 <= 2'b11;
		end
		else if((EX_MEM_RD == RS) && (EX_MEM_RegWrite == 1)) begin 
			FwdCtrl_1 <= 2'b01;
		end
		else if((MEM_WB_RD == RS) && (MEM_WB_RegWrite == 1)) begin
			FwdCtrl_1 <= 2'b10;
		end 
		else begin
			FwdCtrl_1 <= 2'b00;
		end
		
		if((ID_EX_RD == RT) && (ID_EX_RegWrite == 1)) begin
			FwdCtrl_2 <= 2'b11;
		end
		else if((EX_MEM_RD == RT) && (EX_MEM_RegWrite == 1)) begin
			FwdCtrl_2 <= 2'b01;
		end
		else if((MEM_WB_RD == RT) && (MEM_WB_RegWrite == 1)) begin
			FwdCtrl_2 <= 2'b10;
		
		end 
		else begin
			FwdCtrl_2 <= 2'b00;
		end
	end	

endmodule
