module keypad_fsm (
    input clk,
    input [3:0] row,
    output reg [3:0] col,
    output sense,
    output reg [3:0] state,
    output trig
);

    assign trig = |row;
    assign sense = (state == 10);

    always @(posedge clk) begin
        case (state)
            0: begin 
                col <= 4'b1111; 
                state <= 1; 
            end
            1: begin
                if (trig) state <= 2;
            end
            2: begin 
                col <= 4'b0001; 
                state <= 3; 
            end
            3: begin
                if (trig) state <= 10;
                else state <= 4;
            end
            4: begin 
                col <= 4'b0010; 
                state <= 5;
            end
            5: begin
                if (trig) state <= 10;
                else state <= 6;
            end
            6: begin 
                col <= 4'b0100; 
                state <= 7;
            end
            7: begin
                if (trig) state <= 10;
                else state <= 8;
            end
            8: begin 
                col <= 4'b1000; 
                state <= 9;
            end
            9: begin
                if (trig) state <= 10;
                else state <= 0;
            end
            10: begin
                state <= 11;
            end
            11: begin
                if (!trig) state <= 0;
            end
            default: state <= 0;
        endcase
    end

endmodule