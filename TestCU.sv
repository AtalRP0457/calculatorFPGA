module TestCU
( 
    input logic clock,
    input logic clr,
    input logic ClearEntry,
    input [3:0] row,
    output logic Reset, LoadX, LoadY, LoadR, AddSub, trig, IUAU,
    output [3:0] keypadnum, col
);

    keypad_input keypad
    (
        .clk(clock),
        .reset(clr),
        .row(row),
        .col(col),
        .value(keypadnum),
        .trig(trig)
    );

    CU control_unit
    (
        .trig(trig),
        .clr(clr),
        .clearEntry(ClearEntry),
        .val(keypadnum),
        .Reset(Reset),
        .LoadX(LoadX),
        .LoadY(LoadY),
        .LoadR(LoadR),
        .AddSub(AddSub),
        .IUAU(IUAU)
    );

endmodule