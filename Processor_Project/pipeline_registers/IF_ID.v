//A single register

module IF_ID(
	input wire [31:0] PC_in, 
	output reg [31:0] PC_out,
    input wire [31:0] instr_in,
    output reg [31:0] instr_out,
	input wire reset,
	input wire write,
    input wire clock);

    always @(posedge clock) begin
        if (reset == 1'b1) begin //clears register
            instr_out <= 32'h0;
			PC_out<=0;
        end else if (write == 1'b1) begin
            instr_out <= instr_in;
			PC_out<=PC_in;
        end else begin
            instr_out <= instr_out;
			PC_out<=PC_out;
        end
    end

endmodule
