module alu(
    input wire [7:0] a,
    input wire [7:0] b,
    input wire [1:0] op,
    input wire  carry_in,
    output wire [7:0] result,
    output wire zero,
    output wire carry
);


wire [8:0] sum;
assign sum = {1'b0, a} + {1'b0, b};
assign result = selected_sum[7:0];
assign carry = selected_sum[8];
assign zero = (result == 8'd0);
    wire [8:0] adc_sum;
assign adc_sum = {1'b0, a} + {1'b0, b} + {1'b0, carry_in};
wire [8:0] selected_sum;
assign selected_sum = (op == 2'b01) ? adc_sum : sum;
endmodule
