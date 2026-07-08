module BCD2BinarySM(
    input [15:0] BCD,
    output [7:0] binarySM
);
    // Only 3 digits max (hundreds, tens, ones) — max value 127
    // BCD[15:12] is thousands — ignore it (always 0 for valid input)
    wire [7:0] hundreds = {6'b0, BCD[9:8]};  // only 0 or 1
    wire [7:0] tens      = {4'b0, BCD[7:4]};
    wire [7:0] ones      = {4'b0, BCD[3:0]};

    assign binarySM = (hundreds * 8'd100) + (tens * 8'd10) + ones;
endmodule