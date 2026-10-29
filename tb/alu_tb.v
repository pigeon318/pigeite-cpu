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

    a = 8'd255;
    b = 8'd1;

    #10

    
    $display("result=%d carry=%b zero=%b", result, carry, zero);

    a = 8'd0;
    b = 8'd0;

    #10

    
    $display("result=%d carry=%b zero=%b", result, carry, zero);

    a = 8'd127;
    b = 8'd1;

    #10

    
    $display("result=%d carry=%b zero=%b", result, carry, zero);

    a = 8'd255;
    b = 8'd0;
    carry_in = 1'b1;
    op = 2'b01;

    #10;

    $display("ADC: result=%d carry=%b zero=%b",result, carry, zero);

    $finish;
end

endmodule
