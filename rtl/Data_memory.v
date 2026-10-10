module Data_memory (
    input  wire        clk,
    input  wire        MemRead,
    input  wire        MemWrite,
    input  wire [31:0] addr,
    input  wire [31:0] write_data,
    output reg  [31:0] read_data
);

    // 16 KiB data memory (4096 words) for the AES workload.
    reg [31:0] mem [0:4095];

    integer i;
    initial begin
        for (i = 0; i < 4096; i = i + 1)
            mem[i] = 32'h0;
    end

    always @(posedge clk) begin

        if (MemWrite && (addr[31:2] < 4096))
            mem[addr[31:2]] <= write_data;
    end

    always @(*) begin

        if (MemRead && (addr[31:2] < 4096))
            read_data = mem[addr[31:2]];

        else
            read_data = 32'b0;
    end

endmodule
