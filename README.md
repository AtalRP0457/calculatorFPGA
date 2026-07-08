8-Bit Digital Calculator on FPGA

Built an 8-bit digital calculator in SystemVerilog on an Intel DE10-Lite FPGA. The calculator takes input from a custom 4×4 keypad using sign-magnitude representation and displays operands and results on the board's 7-segment displays in real time.

System Design

The project is organized into four main hardware modules:

  Input Unit: Reads user input from the 4×4 keypad and converts it into sign-magnitude values.
  Arithmetic Unit: Performs 8-bit addition and subtraction.
  Output Unit: Displays the entered numbers and final result on the FPGA's 7-segment displays.
  Control Unit: A finite state machine (FSM) that coordinates communication between all modules and controls the overall operation of the calculator.
  Features
  
Supports 
  8-bit signed addition and subtraction.
  Detects overflow and invalid operations.
  Turns on an LED indicator when an overflow occurs.
  Displays an error pattern (----) whenever the result falls outside the supported range.
  Provides real-time feedback through the FPGA's onboard displays.
  Challenges

The biggest challenge was making sure each hardware module communicated correctly. Since every component operates in parallel, I had to carefully design the timing between the Input Unit, Arithmetic Unit, and Control Unit to avoid race conditions and incorrect state transitions.

Working on this project also helped me understand the difference between software programming and digital hardware design. Instead of writing instructions that execute one after another, I learned to think in terms of parallel logic, clock cycles, and register timing.

Tools & Technologies
  SystemVerilog
  Intel Quartus Prime
  ModelSim / QuestaSim
  Intel DE10-Lite FPGA
  4×4 Matrix Keypad

Running the Project
  Open the project in Intel Quartus Prime.
  Compile the top-level module (calculatortop).
  Program the generated .sof file onto the Intel DE10-Lite FPGA.
  Connect the 4×4 keypad to the board and begin entering numbers to perform calculations.
