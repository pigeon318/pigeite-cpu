module register_bank(

    input wire clk,
    input wire reset,
    input wire write_enable,
    input wire [1:0] write_addr,
    input wire [7:0] write_data,
    input wire [1:0] read_addr_a,
    input wire [1:0] read_addr_b,
    output wire [7:0] read_data_a,
    output wire [7:0] read_data_b
);

reg [7:0] register_a;
reg [7:0] register_b;
reg [7:0] register_c;
reg [7:0] register_d;

always @(posedge clk) begin
    if (reset) begin
        register_a <= 8'd0;
        register_b <= 8'd0;
        register_c <= 8'd0;
        register_d <= 8'd0;
    end
    else if (write_enable) begin
        case (write_addr)
            2'b00: register_a <= write_data;
            2'b01: register_b <= write_data;
            2'b10: register_c <= write_data;
            2'b11: register_d <= write_data;
        endcase
    end
end

assign read_data_a = (read_addr_a == 2'b00) ? register_a : (read_addr_a == 2'b01) ? register_b : (read_addr_a == 2'b10) ? register_c : register_d;
assign read_data_b = (read_addr_b == 2'b00) ? register_a : (read_addr_b == 2'b01) ? register_b : (read_addr_b == 2'b10) ? register_c : register_d;





endmodule