`timescale 1ns / 1ps

module activity_counter(
    input  wire       clk,
    input  wire       reset,
    output reg [7:0]  count
);

    always @(posedge clk or posedge reset) begin
        if (reset)
            count <= 8'd0;
        else
            count <= count + 1'b1;
    end

endmodule
