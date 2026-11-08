`timescale 1ns/1ps

module registerbank_tb;

    reg clk;
    reg reset;
    reg write_enable;
    reg [1:0] write_addr;
    reg [7:0] write_data;
    reg [1:0] read_addr_a;
    reg [1:0] read_addr_b;

    wire [7:0] read_data_a;
    wire [7:0] read_data_b;



register_bank dut (
    .clk(clk),
    .reset(reset),
    .write_enable(write_enable),
    .write_addr(write_addr),
    .write_data(write_data),
    .read_addr_a(read_addr_a),
    .read_addr_b(read_addr_b),
    .read_data_a(read_data_a),
    .read_data_b(read_data_b)

);
initial clk = 0;
always #5 clk = ~clk;


initial begin
    reset = 1;
    write_enable = 0;
    write_addr = 2'b00;
    write_data = 8'd0;
    read_addr_a = 2'b00;
    read_addr_b = 2'b01;
    #10;
    reset = 0;
    #2;
    write_enable = 1;
    write_addr = 2'b00;
    write_data = 8'd42;
    #4;
    $display("Register A = %d", read_data_a);

    $finish;
end


endmodule