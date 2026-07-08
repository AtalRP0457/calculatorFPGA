module OU (
    input [7:0] data_in,
    input INVALID,
    output [6:0] HEX0,
    output [6:0] HEX1,
    output [6:0] HEX2,
    output [6:0] HEX3
);

    wire sign;
    wire [7:0] magnitude;

    assign sign = data_in[7];
    assign magnitude = sign ? (~data_in + 8'd1) : data_in;

    wire [3:0] ones, tens;
    wire [1:0] hundreds;

    binary2bcd bcd (
        .A(magnitude),
        .ONES(ones),
        .TENS(tens),
        .HUNDREDS(hundreds)
    );

    wire [6:0] h0, h1, h2;
    wire [6:0] dash = 7'b0111111;

    bcd2seven d0 (.bcd(ones), .display(h0));
    bcd2seven d1 (.bcd(tens), .display(h1));
    bcd2seven d2 (.bcd({2'b00, hundreds}), .display(h2));

    assign HEX0 = INVALID ? dash : h0;
    assign HEX1 = INVALID ? dash : h1;
    assign HEX2 = INVALID ? dash : h2;
    assign HEX3 = INVALID ? dash : (sign ? 7'b0111111 : 7'b1111111);

endmodule