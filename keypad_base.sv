module keypad_base (
    input clk,
    input [3:0] row,
    output [3:0] col,
    output [3:0] value,
    output valid,
    output slow_clock,
    output sense,
    output valid_digit,
    output [3:0] inv_row
);

    assign inv_row = ~row;

    clock_div #(.DIV(2000)) div (
        .clk(clk),
        .clk_out(slow_clock)
    );

    keypad_fsm fsm (
        .clk(slow_clock),
        .row(inv_row),
        .col(col),
        .sense(sense)
    );

    keypad_decoder decoder (
        .row(inv_row),
        .col(col),
        .value(value),
        .valid(valid_digit)
    );

    reg sense_d;
    reg valid_reg;

    always @(posedge slow_clock) begin
        sense_d <= sense;
        valid_reg <= (sense_d && !sense);
    end

    assign valid = valid_reg;

endmodule