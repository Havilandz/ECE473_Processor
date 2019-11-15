//Register File for Processor final project
module Register_File (
	input wire [4:0] RS_addr,
	input wire [4:0] RT_addr,
	input wire [31:0] data_in,
	input wire [4:0] write_address,
	input wire reset,
	input wire WriteEnable,
	input wire clock,
	input wire [4:0] read_address_debug,
	input wire debug_clock,
	output reg [31:0] RS_data,
	output reg [31:0] RT_data,
	output reg [31:0] data_out_debug);

	reg [31:0] register [31:0];
	reg [5:0] i;
	initial begin //initialized all registers to 0
		for (i = 0; i<32; i = i+1) begin
			register[i] = 0;
		end
		
	end
		
	always @ (posedge clock) begin
		if (reset == 1'b1) begin 
            for (i = 0; i<32; i = i+1) begin
				register[i] <= 0;
			end
        end else if (WriteEnable == 1'b1) begin
            register[write_address] <= data_in;
        end
	
	end
	
	
	always @ (negedge clock) begin
		RS_data <= register[RS_addr];
		RT_data <= register[RT_addr];
	end
	
	always @ (posedge debug_clock) begin
            data_out_debug <= register[read_address_debug];	
	
	end
	
endmodule
