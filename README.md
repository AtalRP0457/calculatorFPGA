# 8-Bit, Two-Function Digital Hardware Calculator

[cite_start]An implementation of a custom digital hardware calculator using **SystemVerilog** and an **Intel DE10-Lite FPGA** board[cite: 11, 24]. [cite_start]The system interfaces with an external CSE $4\times4$ KeyPad for sign-magnitude data entry and utilizes onboard 7-segment displays for real-time visualization[cite: 50, 81].

## 🛠️ System Architecture
[cite_start]The calculator is partitioned into four major distinct functional units coordinated by a centralized control unit[cite: 23]:
* [cite_start]**Input Unit (IU):** Captures sign-magnitude decimal inputs from the 4x4 keypad interface[cite: 23, 50, 66].
* [cite_start]**Arithmetic Unit (AU):** Executes 8-bit addition and subtraction operations[cite: 22, 23].
* [cite_start]**Output Unit (OU):** Drives the DE10-Lite 7-segment displays to render operands and signed results[cite: 23, 81, 82].
* [cite_start]**Control Unit (CU):** A Mealy/Moore Finite State Machine (FSM) operating at 50MHz to synchronize data-path routing and module communication[cite: 23, 30, 88].

## ✨ Custom & Advanced Features
Beyond the core requirements, this implementation includes:
* [cite_start]**Invalid Input/Overflow Handling:** Automatically detects operations out of bounds and triggers an overflow indicator on LEDR9[cite: 85]. Out-of-range results display an explicit invalid pattern (`----`) on the 7-segment displays.
* 
## 🧠 Technical Challenges & Lessons Learned
* **Module Synchronization:** One of the main challenges of this project was correctly synchronizing the distinct clock boundaries and handshakes between the Input Unit, Arithmetic Unit, and the Control Unit FSM. Resolving state race conditions required meticulous timing analysis in simulation.
* **Hardware-Software Mindset:** Designing logic blocks in SystemVerilog required a fundamental shift from sequential "software thinking" to parallel hardware execution, emphasizing propagation delays and register loading windows.

## 🚀 How to Run
1. Open the project files in **Intel Quartus Prime** or simulation tools like **Questa/ModelSim**.
2. Compile and synthesize the top-level module `calculatortop`.
3. Program the `.sof` file onto your **Intel DE10-Lite FPGA** board.
4. [cite_start]Interface the CSE KeyPad with the Arduino ICSP port on the board.
