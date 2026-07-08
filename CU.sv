module CU (
    input logic trig,
    input logic reset,
    input logic clk,
    input [3:0] val,
    output logic Reset,
    output logic LoadX,
    output logic LoadY,
    output logic AddSub,
    output logic LoadR,
    output logic IUAU,
    output logic clearEntry,
    output logic INVALID
);

    typedef enum logic [2:0] {
        S0, S1, S2, S3, S4
    } state_t;

    state_t state, next;

    always_ff @(posedge clk or negedge reset) begin
        if (!reset)
            state <= S0;
        else
            state <= next;
    end

    always_comb begin
        next = state;
        case (state)
            S0: next = S1;
            S1: if (trig && (val == 10 || val == 11)) next = S2;
            S2: next = S3;
            S3: if (trig && val == 15) next = S4;
            S4: if (trig && val <= 9) next = S1;
        endcase
    end

    always_ff @(posedge clk or negedge reset) begin
        if (!reset) begin
            LoadX <= 0;
            LoadY <= 0;
            LoadR <= 0;
            IUAU <= 0;
            clearEntry <= 0;
            AddSub <= 0;
            INVALID <= 0;
            Reset <= 0;
        end
        else begin
            LoadX <= 0;
            LoadY <= 0;
            LoadR <= 0;
            clearEntry <= 0;
            IUAU <= 0;
            INVALID <= 0;
            Reset <= 1;

            case (state)
                S1: begin
                    if (trig && (val == 10 || val == 11)) begin
                        LoadX <= 1;
                        AddSub <= (val == 11);
                        clearEntry <= 1;
                    end
                    if (trig && val == 15)
                        INVALID <= 1;
                end

                S2: begin
                    if (trig && (val == 10 || val == 11))
                        INVALID <= 1;
                end

                S3: begin
                    if (trig && val == 15)
                        LoadY <= 1;
                end

                S4: begin
                    LoadR <= 1;
                    IUAU <= 1;
                    if (trig && val == 15)
                        INVALID <= 1;
                end
            endcase
        end
    end

endmodule