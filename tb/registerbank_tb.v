
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
    $display("register a = %d", read_data_a);
    if (read_data_a !== 8'd42) begin
        $fatal(1, "register a test failed");
    end

    write_addr = 2'b01;
    write_data = 8'd100;
    read_addr_a = 2'b01;

    #10;
    $display("register b = %d", read_data_a);
    if (read_data_a !== 8'd100) begin
        $fatal(1, "register b test failed");
    end

    write_addr = 2'b10;
    write_data = 8'd175;
    read_addr_a = 2'b10;

    #10;
    $display("register c = %d", read_data_a);
    if (read_data_a !== 8'd175) begin
        $fatal(1, "register c test failed");
    end

    write_addr = 2'b11;
    write_data = 8'd250;
    read_addr_a = 2'b11;

    #10;
    $display("register d = %d", read_data_a);
    if (read_data_a !== 8'd250) begin
        $fatal(1, "register d test failed");
    end

    write_enable = 0;
    write_addr = 2'b00;
    write_data = 8'd200;
    read_addr_a = 2'b00;

    #10;
    $display("register a after disabled write = %d", read_data_a);
    if (read_data_a !== 8'd42) begin
        $fatal(1, "disabled write test failed");
    end

    reset = 1;
    write_enable = 1;
    write_addr = 2'b00;
    write_data = 8'd200;

    #10;
    $display("register a after reset = %d", read_data_a);
    if (read_data_a !== 8'd0) begin
        $fatal(1, "reset priority test failed");
    end

    reset = 0;
    write_enable = 0;

    read_addr_a = 2'b01;
    read_addr_b = 2'b11;

    #1;

    $display("read port a = %d", read_data_a);
    $display("read port b = %d", read_data_b);

    if (read_data_a !== 8'd0 || read_data_b !== 8'd0) begin
        $fatal(1, "dual read port test failed");
    end

    write_enable = 1;
    write_addr = 2'b01;
    write_data = 8'd123;

    #10;

    write_addr = 2'b11;
    write_data = 8'd234;

    #10;

    write_enable = 0;
    read_addr_a = 2'b01;
    read_addr_b = 2'b11;

    #1;

    $display("read port a = %d", read_data_a);
    $display("read port b = %d", read_data_b);

    if (read_data_a !== 8'd123 || read_data_b !== 8'd234) begin
        $fatal(1, "independent read port test failed");
    end

    reset = 1;
    write_enable = 0;

    #10;

    read_addr_a = 2'b00;
    read_addr_b = 2'b01;

    #1;

    if (read_data_a !== 8'd0 || read_data_b !== 8'd0) begin
        $fatal(1, "reset failed for a or b");
    end

    read_addr_a = 2'b10;
    read_addr_b = 2'b11;

    #1;

    if (read_data_a !== 8'd0 || read_data_b !== 8'd0) begin
        $fatal(1, "reset failed for c or d");
    end

    $display("all four registers reset successfully");

    $finish;
end


endmodule
