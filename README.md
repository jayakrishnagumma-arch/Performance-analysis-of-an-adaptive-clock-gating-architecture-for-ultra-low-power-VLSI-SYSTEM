# Design and Performance Analysis of an Adaptive Clock Gating Architecture for Ultra Low Power VLSI System

## Team Members
- Benjamin Defin.T
- Balu.BS
- Jayakrishna.G

## Project Overview
This project implements an adaptive clock-gating architecture in Verilog HDL for reducing unnecessary clock activity in low-power VLSI systems.

The supplied project document describes adaptive clock gating, a latch/ICG-based approach, test override, reference-register verification, and a target reduction in unnecessary clock switching. It also provides a Vivado-oriented implementation using an adaptive controller, `BUFGCE` clock gating, and an activity counter.

## Repository Structure
```text
Adaptive_Clock_Gating/
├── src/
│   ├── adaptive_clock_gating.v
│   ├── adaptive_clock_gating_top.v
│   ├── clock_gate.v
│   └── activity_counter.v
├── sim/
│   └── adaptive_clock_gating_tb.v
├── vivado/
│   └── create_project.tcl
├── docs/
│   ├── BALU_VLSI_1.docx
│   └── vivado_output_reference.jpg
├── constraints/
│   └── README.md
└── README.md
```

## Working Principle
1. `activity` indicates whether useful switching activity is present.
2. The adaptive controller keeps `clock_enable` high while activity is present.
3. During inactivity, an idle counter runs.
4. After `IDLE_LIMIT` inactive cycles, the clock enable is turned off.
5. `BUFGCE` generates `gated_clk` from the system clock.
6. The activity counter increments only on gated-clock edges.
7. `status = {activity, clock_enable, gated_clk}` is provided for observation.

## Simulation
The testbench uses a 100 MHz clock (`#5` half-period). The sequence turns activity on, then off long enough for the adaptive controller to enter the gated state, and finally turns activity on again.

### Expected waveform behavior
- During reset: clock enable is low and the counter is cleared.
- During activity: `clock_enable` becomes high and `gated_clk` follows the system clock.
- During prolonged inactivity: `clock_enable` eventually becomes low and `gated_clk` stops toggling.
- When activity returns: `clock_enable` becomes high again and the counter resumes.

## Vivado
The design uses Xilinx/AMD `BUFGCE`, so it is intended for a Xilinx/AMD FPGA flow. Open the project in Vivado or run the supplied Tcl script to create the project.

## Important source note
The supplied DOCX contains the top-level/controller instantiation and the `clock_gate`, `activity_counter`, and testbench sections, but the full `adaptive_clock_gating` controller body is not present in the extracted program section. The controller in `src/adaptive_clock_gating.v` is therefore a completed implementation based on the documented interface and the `IDLE_LIMIT=50000` behavior shown in the supplied material; it should be treated as a project completion rather than a verbatim copy of the missing section.

## Reference Output
The supplied Vivado screenshot is stored at:
`docs/vivado_output_reference.jpg`

It is also displayed below when viewed on GitHub:

![Vivado simulation reference](docs/vivado_output_reference.jpg)

## Report Result Stated in the Supplied Document
The supplied report states that, for its separate data-dependent test pattern, clock edges at the gated register were reduced from 22 to 6 (about 72.7%) while maintaining the same output as an ungated reference register. That result should not be treated as a measured result of this activity-counter implementation unless the corresponding testbench is run.

## Future Scope
- Wider datapaths and shared gating logic
- FPGA clock-enable primitives such as `BUFGCE`
- Prediction-based activity gating
- Machine-learning-based activity prediction
- Combination with DVFS and power gating
- Vivado power analysis and gate-level simulation
- Processor/MAC integration
- ASIC implementation with standard-cell ICG cells

## Tools
- Verilog HDL
- Xilinx/AMD Vivado
- Vivado Simulator
- Xilinx FPGA `BUFGCE`

## License
Academic/project use.
