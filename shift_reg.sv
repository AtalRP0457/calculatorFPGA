module shift_reg
#(parameter COUNT = 4, WIDTH = 4)
(
    input                          clk,
    input                          trig,
    input                          reset,
    input                          dir,
    input  [WIDTH-1:0]             in,
    output reg [(COUNT*WIDTH)-1:0] out
);
    initial out = 0;

    always @(posedge clk or negedge reset) begin
        if (!reset)
            out <= 0;
        else if (trig)
            out <= {out[(COUNT*WIDTH-WIDTH-1):0], in};
    end
endmodule