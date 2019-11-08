//A single register

module IF_ID(
    input wire [31:0] instr_in,
    output reg [31:0] instr_out,
	input wire reset,
	input wire write,
    input wire clock);

    always @(posedge clock) begin
        if (reset == 1'b1) begin //clears register
            instr_out <= 32'h0;
        end else if (write == 1'b1) begin
            instr_out <= instr_in;
        end else begin
            instr_out <= instr_out;
        end
    end

endmodule
