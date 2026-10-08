`timescale 1ns / 1ps

module adaptive_clock_gating_top(
    input  wire       clk,
    input  wire       reset,
    input  wire       activity,
    output wire [7:0] count,
    output wire [2:0] status
);

    wire clock_enable;
    wire gated_clk;

    // Adaptive clock gating controller
    adaptive_clock_gating #(
        .IDLE_LIMIT(16'd50000)
    ) gating_controller (
        .clk          (clk),
        .reset        (reset),
        .activity     (activity),
        .clock_enable (clock_enable)
    );

    // FPGA clock buffer with clock enable
    clock_gate clock_gate_inst (
        .clk       (clk),
        .enable    (clock_enable),
        .gated_clk (gated_clk)
    );

    // Counter demonstrates the effect of gated clock activity
    activity_counter counter_inst (
        .clk   (gated_clk),
        .reset (reset),
        .count (count)
    );

    // Status = {activity, clock_enable, gated_clk}
    assign status = {activity, clock_enable, gated_clk};

endmodule
