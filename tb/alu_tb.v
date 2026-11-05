
`timescale 1ns/1ps

module alu_tb;

    reg [7:0] a;
    reg [7:0] b;
    reg [1:0] op;
    reg carry_in;

    wire [7:0] result;
    wire zero;
    wire carry;

    alu uut (
        .a(a),
        .b(b),
        .op(op),
        .carry_in(carry_in),
        .result(result),
        .zero(zero),
        .carry(carry)
    );

    initial begin
    a = 8'd200;
    b = 8'd100;
    op = 2'b00;
    carry_in = 1'b0;

    #10;

    $display("result=%d carry=%b zero=%b", result, carry, zero);

    if (result !== 8'd44 || carry !== 1'b1 || zero !== 1'b0) begin
        $display("FAIL: ADD 200 + 100");
        $fatal(1);
    end

    a = 8'd255;
    b = 8'd1;

    #10

    
    $display("result=%d carry=%b zero=%b", result, carry, zero);

    if (result !== 8'd0 || carry !== 1'b1 || zero !== 1'b1) begin
        $display("FAIL: ADD 255 + 1");
        $fatal(1);
    end

    a = 8'd0;
    b = 8'd0;

    #10

    
    $display("result=%d carry=%b zero=%b", result, carry, zero);

    if (result !== 8'd0 || carry !== 1'b0 || zero !== 1'b1) begin
        $display("FAIL: ADD 0 + 0");
        $fatal(1);
    end

    a = 8'd127;
    b = 8'd1;

    #10

    
    $display("result=%d carry=%b zero=%b", result, carry, zero);

    if (result !== 8'd128 || carry !== 1'b0 || zero !== 1'b0) begin
        $display("FAIL: ADD 127 + 1");
        $fatal(1);
    end

    a = 8'd255;
    b = 8'd0;
    carry_in = 1'b1;
    op = 2'b01;

    #10;

    $display("ADC: result=%d carry=%b zero=%b",result, carry, zero);

    if (result !== 8'd0 || carry !== 1'b1 || zero !== 1'b1) begin
        $display("FAIL: ADC 255 + 0 + 1");
        $fatal(1);
    end

    a = 8'd20;
    b = 8'd35;
    op = 2'b10;
    carry_in = 1'b0;

    #10;

    $display("SUB: result=%d carry=%b zero=%b", result, carry, zero);

    if (result !== 8'd241 || carry !== 1'b1 || zero !== 1'b0) begin
        $display("FAIL: SUB 20 - 35");
        $fatal(1);
    end

    a = 8'd35;
    b = 8'd20;
    op = 2'b10;

    #10;

    $display("SUB no borrow: result=%d carry=%b zero=%b",result, carry, zero);

    if (result !== 8'd15 || carry !== 1'b0 || zero !== 1'b0) begin
        $display("FAIL: SUB 35 - 20");
        $fatal(1);
    end

    a = 8'd42;
    b = 8'd42;
    op = 2'b10;

    #10;

    $display("SUB to zero: result=%d carry=%b zero=%b",result, carry, zero);

    if (result !== 8'd0 || carry !== 1'b0 || zero !== 1'b1) begin
        $display("FAIL: SUB 42 - 42");
        $fatal(1);
    end

    a = 8'd20;
    b = 8'd35;
    op = 2'b11;

    #10;

    $display("CMP: result=%d carry=%b zero=%b",result, carry, zero);

    if (result !== 8'd241 || carry !== 1'b1 || zero !== 1'b0) begin
        $display("FAIL: CMP 20 < 35");
        $fatal(1);
    end

    a = 8'd42;
    b = 8'd42;
    op = 2'b11;

    #10;

    $display("CMP equal: result=%d carry=%b zero=%b",result, carry, zero);

    if (result !== 8'd0 || carry !== 1'b0 || zero !== 1'b1) begin
        $display("FAIL: CMP 42 == 42");
        $fatal(1);
    end

    a = 8'd35;
    b = 8'd20;
    op = 2'b11;

    #10;

    $display("CMP greater: result=%d carry=%b zero=%b",result, carry, zero);

    if (result !== 8'd15 || carry !== 1'b0 || zero !== 1'b0) begin
        $display("FAIL: CMP 35 > 20");
        $fatal(1);
    end

    $finish;
end

endmodule
