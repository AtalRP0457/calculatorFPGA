module IU (
    input [3:0] row,
    input clk,
    input reset,
    output [3:0] col,
    output [3:0] value,
    output trig,
    output [7:0] final_val,
    output LEDR9
);

    wire [(4*4)-1:0] out;
    wire [7:0] binarySM;

    keypad_base keypad_base(
        .clk(clk),
        .row(row),
        .col(col),
        .value(value),
        .valid(trig)
    );

    shift_reg #(.COUNT(4)) shift_reg(
        .trig(trig),
        .in(value),
        .out(out),
        .reset(reset),
        .dir(1'b0)
    );

    BCD2BinarySM #(.N(8)) bcd_to_bin(
        .BCD(out),
        .binarySM(binarySM)
    );

    assign final_val = binarySM;
    assign LEDR9 = 0;

endmodule