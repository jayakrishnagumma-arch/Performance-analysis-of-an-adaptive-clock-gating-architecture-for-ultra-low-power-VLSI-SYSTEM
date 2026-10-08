`timescale 1ns / 1ps

// Xilinx/AMD FPGA clock gate using BUFGCE.
module clock_gate(
    input  wire clk,
    input  wire enable,
    output wire gated_clk
);

    BUFGCE clock_buffer (
        .I  (clk),
        .CE (enable),
        .O  (gated_clk)
    );

endmodule
