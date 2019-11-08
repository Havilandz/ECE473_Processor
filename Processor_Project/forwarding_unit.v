//Forwarding Controller for 5 stage mips pipeline processor


module forwarding_unit(
	input wire [4:0] EX_MEM_RD,
	input wire [4:0] MEM_WB_RD,
	input wire EX_MEM_RegWrite,
	input wire MEM_WB_RegWrite,
	input wire [4:0] ID_EX_RS,
	input wire [4:0] ID_EX_RT,
	
	output reg [1:0] FwdCtrl_1,
	output reg [1:0] FwdCtrl_2
);

	/*Forward control notes
		01: grab value from ex/mem register
		10: grab value from mem_mux
	*/
	
	
	always @(*) begin
		if((EX_MEM_RD == ID_EX_RS) && (EX_MEM_RegWrite == 1)) begin 
			FwdCtrl_1 <= 2'b01;
		end
		else if((MEM_WB_RD == ID_EX_RS) && (MEM_WB_RegWrite == 1)) begin
			FwdCtrl_1 <= 2'b10;
		end 
		else begin
			FwdCtrl_1 <= 2'b00;
		end
		
		if((EX_MEM_RD == ID_EX_RT) && (EX_MEM_RegWrite == 1)) begin
			FwdCtrl_2 <= 2'b01;
		end
		else if((MEM_WB_RD == ID_EX_RT) && (MEM_WB_RegWrite == 1)) begin
			FwdCtrl_2 <= 2'b10;
		
		end 
		else begin
			FwdCtrl_2 <= 2'b00;
		end

	end
endmodule
