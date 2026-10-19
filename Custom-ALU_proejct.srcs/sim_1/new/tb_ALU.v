`timescale 1ns / 1ps

module tb_alu;

    // Parameters
    parameter WIDTH = 16;

    // Testbench signals (Inputs as reg, Outputs as wire)
    reg  [WIDTH-1:0] tb_a;
    reg  [WIDTH-1:0] tb_b;
    reg              tb_cin;
    reg  [4:0]       tb_opcode;

    wire [WIDTH-1:0] tb_result;
    wire             tb_zero;
    wire             tb_carry;

    // Instruction Opcodes (matching your ALU module)
    localparam ADD    = 5'b00000;
    localparam SUB    = 5'b00001;
    localparam MULT   = 5'b00010;
    localparam AND    = 5'b00011;
    localparam OR     = 5'b00100;
    localparam NAND   = 5'b00101;
    localparam NOR    = 5'b00110;
    localparam XOR    = 5'b00111;
    localparam XNOR   = 5'b01000;
    localparam SLT    = 5'b01001;
    localparam LSL    = 5'b01010;
    localparam LSR    = 5'b01011;
    localparam ASR    = 5'b01100;
    localparam ROL    = 5'b01101;
    localparam ROR    = 5'b01110;
    localparam INC    = 5'b01111;
    localparam DEC    = 5'b10000;
    localparam PASS_A = 5'b10001;
    localparam ADC    = 5'b10010;

    // Instantiate the Unit Under Test (UUT)
    ALU #(
        .WIDTH(WIDTH)
    ) uut (
        .a(tb_a),
        .b(tb_b),
        .cin(tb_cin),
        .opcode(tb_opcode),
        .result(tb_result),
        .zero(tb_zero),
        .carry(tb_carry)
    );

    // Test Stimulus Vector
    initial begin
        // Initialize Inputs
        tb_a = 0;
        tb_b = 0;
        tb_cin = 0;
        tb_opcode = 0;
        #20;

        // 1. ADD: 10 + 15 = 25
        tb_a = 16'd10; tb_b = 16'd15; tb_opcode = ADD; #10;

        // 2. SUB: 20 - 5 = 15
        tb_a = 16'd20; tb_b = 16'd5;  tb_opcode = SUB; #10;

        // 3. MULT: 12 * 4 = 48
        tb_a = 16'd12; tb_b = 16'd4;  tb_opcode = MULT; #10;

        // 4. AND: 12 (1100) & 10 (1010) = 8 (1000)
        tb_a = 16'd12; tb_b = 16'd10; tb_opcode = AND; #10;

        // 5. OR: 12 (1100) | 10 (1010) = 14 (1110)
        tb_a = 16'd12; tb_b = 16'd10; tb_opcode = OR; #10;

        // 6. NAND: ~(12 & 10)
        tb_a = 16'd12; tb_b = 16'd10; tb_opcode = NAND; #10;

        // 7. NOR: ~(12 | 10)
        tb_a = 16'd12; tb_b = 16'd10; tb_opcode = NOR; #10;

        // 8. XOR: 12 ^ 10 = 6 (0110)
        tb_a = 16'd12; tb_b = 16'd10; tb_opcode = XOR; #10;

        // 9. XNOR: ~(12 ^ 10)
        tb_a = 16'd12; tb_b = 16'd10; tb_opcode = XNOR; #10;

        // 10. SLT: 5 < 10 (True -> 1)
        tb_a = 16'd5;  tb_b = 16'd10; tb_opcode = SLT; #10;

        // 11. LSL: 4 << 1 = 8
        tb_a = 16'd4;                 tb_opcode = LSL; #10;

        // 12. LSR: 16 >> 1 = 8
        tb_a = 16'd16;                tb_opcode = LSR; #10;

        // 13. ASR: Signed shift right (-8 >>> 1)
        tb_a = 16'hFFF8;              tb_opcode = ASR; #10;

        // 14. ROL: Rotate left
        tb_a = 16'b1000_0000_0000_0001; tb_opcode = ROL; #10;

        // 15. ROR: Rotate right
        tb_a = 16'b0000_0000_0000_0001; tb_opcode = ROR; #10;

        // 16. INC: 99 + 1 = 100
        tb_a = 16'd99;                tb_opcode = INC; #10;

        // 17. DEC: 100 - 1 = 99
        tb_a = 16'd100;               tb_opcode = DEC; #10;

        // 18. PASS_A: Pass 1234 straight through
        tb_a = 16'd1234;              tb_opcode = PASS_A; #10;

        // 19. ADC: 10 + 20 + cin(1) = 31
        tb_a = 16'd10; tb_b = 16'd20; tb_cin = 1'b1; tb_opcode = ADC; #10;

        // Finish simulation
        $finish;
    end

endmodule