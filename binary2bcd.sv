module binary2bcd (
    input  [7:0] A,
    output [3:0] ONES,
    output [3:0] TENS,
    output [1:0] HUNDREDS
);
    assign ONES     = A % 10;
    assign TENS     = (A / 10) % 10;
    assign HUNDREDS = A / 100;
endmodule