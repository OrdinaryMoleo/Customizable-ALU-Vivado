module ALU #(
    parameter WIDTH = 16
)(
    input  [WIDTH-1:0] a, b,
    input              cin,
    input  [4:0]       opcode,
    output reg [WIDTH-1:0] result,
    output             zero,
    output reg         carry
);

    //Instruction Set Parameters

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
    //19 out of 32 used, 13 values empty for future additions as per requirement
   
   
    // Internal register 1 bit wider than WIDTH to catch the carry-out
    reg [WIDTH:0] extended_result;

    // Zero flag continuous assignment (using the reduction NOR operator)
    assign zero = ~|result;

    always @(*) begin
        extended_result = 0;
        carry = 0;
    
        case (opcode)                                     
            ADD: begin
                extended_result = a + b;
                carry = extended_result[WIDTH];
            end
            
            SUB: begin
                extended_result = a - b;
                carry = extended_result[WIDTH];
            end
            
            MULT: begin
                extended_result = a * b;
                carry = extended_result[WIDTH]; 
            end
            
            AND: begin
                extended_result = a & b;
            end
            
            OR: begin
                extended_result = a | b;
            end
            
            NAND: begin
                extended_result = ~ (a & b);
            end
            
            NOR: begin
                extended_result = ~(a | b);
            end
            
            XOR: begin
                extended_result = a ^ b;
            end
            
            XNOR: begin
                extended_result = ~ (a ^ b);
            end
            
            SLT: begin
                extended_result = (a < b) ? 1 : 0;
            end
            
            LSL: begin
                extended_result = a << 1;
            end
            
            LSR: begin
                extended_result = a >> 1;
            end
            
            ASR: begin
                extended_result = $signed(a) >>> 1;
            end
            
            ROL: begin
                extended_result = {1'b0, a[WIDTH-2:0], a[WIDTH-1]};
            end
            
            ROR: begin
                extended_result = {1'b0, a[0], a[WIDTH-1:1]};
            end
            
            INC: begin
                extended_result = a + 1;
                carry = extended_result[WIDTH];
            end
            
            DEC: begin
                extended_result = a - 1;
            end
            
            PASS_A: begin
                extended_result = a;
            end
            
            ADC: begin
                extended_result = a + b + cin;
                carry = extended_result[WIDTH];
            end
            
            default: extended_result = 0;
        endcase

        // 3. Drive the final output
        result = extended_result[WIDTH-1:0];
    end
    
endmodule