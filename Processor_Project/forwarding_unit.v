//Forwarding Controller for 5 stage mips pipeline processor


module forwarding_unit(
	input wire [4:0] EX_MEM_RD,
	input wire [4:0] MEM_WB_RD,
	input wire EX_MEM_RegWrite,
	input wire MEM_WB_RegWrite,
	input wire [4:0] ID_EX_RS,
	input wire [4:0] ID_EX_RT,
	input wire [4:0] RS_ADDR,
	input wire [4:0] RT_ADDR,
	
	output reg [1:0] FwdCtrl_1,
	output reg [1:0] FwdCtrl_2,
	output reg [1:0] FwdCtrl_3,
	output reg [1:0] FwdCtrl_4 
);

	/*Forward control notes 
		for fwdctrl 1/2
		01: grab value from ex/mem register
		10: grab value from mem_mux
		
		fwdctrl 3:
		1: forwards WB output to ID_EX RS_DATA register
		0: uses RS value from register file
		
		fwdctrl 4:
		00: normal datapath from register file
		01: takes RT_data from EX_MEM register
		10: takes RT_data from MEM_WB regsiter
		
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
	//forwards to decode stage
	always @(*) begin
		if((MEM_WB_RD == RS_ADDR) && (MEM_WB_RegWrite == 1)) begin
			FwdCtrl_3 <= 2'b01;
		end
		else if((MEM_WB_RD == RT_ADDR) && (MEM_WB_RegWrite == 1)) begin
			FwdCtrl_3 <= 2'b10;
		end
		else begin
			FwdCtrl_3 <= 2'b00;
		end
	end
	
	//forwards data from RAM back to ram, more or less
	always @(*) begin
		if((EX_MEM_RD == ID_EX_RT) && (EX_MEM_RegWrite == 1)) begin 
			FwdCtrl_4 <= 2'b01;
		end
		else if((MEM_WB_RD == ID_EX_RT) && (MEM_WB_RegWrite == 1)) begin
			FwdCtrl_4 <= 2'b10;
		end
		else begin
			FwdCtrl_4 <= 2'b00;
		end 
	end

endmodule
