module clock_div #(parameter DIV = 200000) (
    input  clk,
    output reg clk_out
);
    integer count = 0;
    always @(posedge clk) begin
        if (count >= DIV - 1) begin
            count     <= 0;
            clk_out <= ~clk_out;
        end else
            count <= count + 1;
    end
endmodule
