`timescale 1ns / 1ps

// Adaptive clock-enable controller.
// Keeps the clock enabled while activity is present and disables it
// after IDLE_LIMIT consecutive inactive clock cycles.
module adaptive_clock_gating #(
    parameter [15:0] IDLE_LIMIT = 16'd50000
)(
    input  wire       clk,
    input  wire       reset,
    input  wire       activity,
    output reg        clock_enable
);

    reg [15:0] idle_count;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            idle_count   <= 16'd0;
            clock_enable <= 1'b0;
        end else if (activity) begin
            idle_count   <= 16'd0;
            clock_enable <= 1'b1;
        end else if (clock_enable) begin
            if (idle_count >= IDLE_LIMIT - 1'b1) begin
                idle_count   <= idle_count;
                clock_enable <= 1'b0;
            end else begin
                idle_count   <= idle_count + 1'b1;
                clock_enable <= 1'b1;
            end
        end else begin
            idle_count   <= idle_count;
            clock_enable <= 1'b0;
        end
    end

endmodule
