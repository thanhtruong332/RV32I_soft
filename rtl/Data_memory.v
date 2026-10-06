module Data_memory(
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
        for(i = 0; i < 4096; i = i + 1)
            mem[i] = 32'h0;
    end

    // 2. Kênh Ghi: Thêm bảo vệ, chỉ ghi khi địa chỉ hợp lệ
    always @(posedge clk) begin
        // Giới hạn index dưới 4096 để không văng lỗi tràn mảng
        if (MemWrite && (addr[31:2] < 4096))
            mem[addr[31:2]] <= write_data;
    end

    // 3. Kênh Đọc: Thêm màng lọc X
    always @(*) begin
        // Nếu đòi đọc và địa chỉ nằm trong vùng an toàn thì trả data
        if (MemRead && (addr[31:2] < 4096))
            read_data = mem[addr[31:2]];
        // Nếu địa chỉ tào lao thì ném ra số 0 để CPU không dính X
        else
            read_data = 32'b0;
    end

endmodule
