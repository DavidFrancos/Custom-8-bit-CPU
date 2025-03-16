# 🖥️ Custom 8-bit CPU with UART Debugging (Verilog, FPGA)

## 📌 Project Overview

This project implements a **custom 8-bit CPU** designed in Verilog for FPGA-based execution. The system:

- **Fetches, decodes, and executes instructions** using a **custom Instruction Set Architecture (ISA)**.
- **Performs arithmetic and logical operations** via a dedicated **Arithmetic Logic Unit (ALU)**.
- **Manages program flow** with a **Program Counter (PC)** and conditional jumps.
- **Communicates with a PC via UART** for debugging and instruction monitoring.
- **Runs programs stored in `program.mem`**, simulating ROM-based execution.
- **Is fully synthesizable** on the **ICEBreaker FPGA** and can be extended further.

---

## ⚡ Features

✅ **Custom 8-bit Instruction Set (ISA)**  
✅ **Fully functional ALU (ADD, SUB, AND, OR, XOR, etc.)**  
✅ **Register File with read/write operations**  
✅ **Instruction Memory for preloaded programs (`program.mem`)**  
✅ **Program Counter (PC) with jump support**  
✅ **UART Communication (115200 baud) for debugging**  
✅ **Fully synthesizable on ICEBreaker FPGA**  

---

## 📜 Hardware Requirements

🖥️ **ICEBreaker FPGA (Lattice iCE40UP5K)**  
🔌 **USB-UART Interface (FTDI/CH340) for PC communication**  
🖧 **PC with a Serial Monitor** (Tera Term, Minicom, PuTTY, etc.)  

---

## 🛠️ File Structure

│── cpu.v # Top-level CPU module (connects all components) 
│── alu.v # Arithmetic Logic Unit (ALU) for computations
│── control_unit.v # Control logic for instruction execution 
│── instruction_decoder.v # Decodes instructions and extracts operands
│── instruction_memory.v # Stores program instructions (ROM)
│── program.mem # Example program stored in memory 
│── program_counter.v # Handles program flow control (PC updates, jumps) 
│── register_file.v # Stores CPU register values
│── uartcommtx.v # UART Transmitter for debugging
│── uartcommrx.v # UART Receiver (Future external instruction loading)
│── constraints.pcf # FPGA pin assignments
│── README.md # Project documentation

---

## 💾 Synthesis & Programming (ICEBreaker FPGA)

Use the following commands to **synthesize and upload** the design to the FPGA:

```sh
yosys -p "synth_ice40 -top cpu -json cpu.json" \
      cpu.v alu.v control_unit.v instruction_decoder.v \
      instruction_memory.v program_counter.v register_file.v \
      uartcommtx.v uartcommrx.v

nextpnr-ice40 --up5k --package sg48 --json cpu.json --pcf constraints.pcf --asc cpu.asc
icepack cpu.asc cpu.bin
iceprog cpu.bin
```

---

🔍 How It Works
Instruction Fetch: The CPU retrieves an instruction from instruction memory (program.mem).
Instruction Decode: The decoder extracts the opcode, operands, and jump address.
Execution: The ALU performs the operation, and the result is stored in registers.
Jump Handling: The program counter updates based on jump instructions.
UART Debugging: The system sends ALU results, register values, and program counter updates over UART for real-time monitoring.

---

🚀 Future Improvements
Implement UART RX (uartcommrx) to allow external instruction loading from the PC.
Expand instruction set to include load/store operations (LD, ST).
Implement a stack for function calls and subroutines.
Add a 7-segment display interface for real-time debugging.

---

📌 Created by David Francos – inspired by classic microprocessors.
