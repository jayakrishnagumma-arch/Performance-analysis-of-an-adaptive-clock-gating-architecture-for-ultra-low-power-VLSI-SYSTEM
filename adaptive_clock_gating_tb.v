`timescale 1ns / 1ps

module adaptive_clock_gating_tb;

    reg clk;
    reg reset;
    reg activity;

    wire [7:0] count;
    wire [2:0] status;

    adaptive_clock_gating_top uut (
        .clk      (clk),
        .reset    (reset),
        .activity (activity),
        .count    (count),
        .status   (status)
    );

    // 100 MHz clock: 10 ns period
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    // Test sequence
    initial begin
        reset    = 1'b1;
        activity = 1'b0;

        #100;
        reset = 1'b0;

        // Activity ON
        #100;
        activity = 1'b1;
        #1000;

        // Activity OFF: controller becomes idle after IDLE_LIMIT cycles
        activity = 1'b0;
        #600000;

        // Activity ON again
        activity = 1'b1;
        #1000;

        #1000;
        $finish;
    end

    initial begin
        $monitor("t=%0t ns reset=%b activity=%b count=%0d status=%b",
                 $time, reset, activity, count, status);
    end

endmodule
