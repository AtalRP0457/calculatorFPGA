module keypad_input (
    input clk,
    input reset,
    input iu_clear,
    input [3:0] row,
    output [3:0] col,
    output reg [3:0] keypad_val,
    output reg trig,
    output reg [7:0] data_out
);

    wire [3:0] value_int;
    wire valid_int;

    keypad_base kb (
        .clk(clk),
        .row(row),
        .col(col),
        .value(value_int),
        .valid(valid_int)
    );

    reg valid_d;

    always @(posedge clk or negedge reset) begin
        if (!reset)
            valid_d <= 0;
        else
            valid_d <= valid_int;
    end

    wire trig_pulse = valid_int & ~valid_d;

    always @(posedge clk or negedge reset) begin
        if (!reset) begin
            keypad_val <= 0;
            trig <= 0;
        end
        else begin
            trig <= trig_pulse;
            if (trig_pulse)
                keypad_val <= value_int;
        end
    end

    reg [7:0] magnitude;
    reg sign;

    always @(posedge clk or negedge reset) begin
        if (!reset) begin
            magnitude <= 0;
            sign <= 0;
        end
        else if (iu_clear) begin
            magnitude <= 0;
            sign <= 0;
        end
        else if (trig_pulse) begin
            if (value_int <= 9) begin
                magnitude <= (magnitude * 8'd10) + value_int;
            end
            else if (value_int == 4'd14) begin
                sign <= ~sign;
            end
        end
    end

    always @(*) begin
        if (sign)
            data_out = ~magnitude + 1;
        else
            data_out = magnitude;
    end

endmodule