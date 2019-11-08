//A single register

module three_register(
    input wire [31:0] data_in_1,
    output reg [31:0] data_out_1,
	input wire [31:0] data_in_2,
    output reg [31:0] data_out_2,
	input wire [4:0] data_in_3,
    output reg [4:0] data_out_3,
    input wire reset,
    input wire write,
	input wire clock);

    always @(posedge clock) begin
        if (reset == 1'b1) begin //clears register
            data_out_1 <= 32'h0;
			data_out_2 <= 32'h0;
			data_out_3 <= 32'h0;
        end else if (write == 1'b1) begin
            data_out_1 <= data_in_1;
			data_out_2 <= data_in_2;
			data_out_3 <= data_in_3;
        end else begin
            data_out_1 <= data_out_1;
			data_out_2 <= data_out_2;
			data_out_3 <= data_out_3;
        end
    end

endmodule
