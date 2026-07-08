module mux(
    input [7:0] IU,
    input [7:0] AU,
    input sel,
    output [7:0] Y
);
    assign Y = sel ? AU : IU;
endmodule