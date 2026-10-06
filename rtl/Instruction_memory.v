module Instruction_memory(
    input   wire    [31:0]  pc,
    output  wire    [31:0]  Instruction
);
    reg [31:0]  mem [0:4095];
    assign  Instruction =   mem[pc[31:2]]; 
endmodule
