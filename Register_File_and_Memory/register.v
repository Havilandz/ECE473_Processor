//A single register

module register(
    input wire clock,
    input wire reset,
    input wire write,
    input wire [31:0] data_in,
    output reg [31:0] data_out);

    always @(posedge clock) begin
        if (reset == 1'b1) begin //clears register
            data_out <= 32'h0;
        end else if (write == 1'b1) begin
            data_out <= data_in;
        end else begin
            data_out <= data_out;
        end
    end

endmodule
