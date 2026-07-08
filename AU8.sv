module AU8 (
	 input clk,
    input [7:0] X,
    input InA, InB, Out, Clear, Add_Subtract,
    output reg [7:0] Rout,
    output reg OVR,
    output ZERO
);

    reg [7:0] A, B;
    wire [7:0] Result;

    assign Result = (Add_Subtract == 0) ? (A + B) : (A - B);
    assign ZERO = (Result == 0);

    always @(posedge clk or posedge Clear) begin
        if (Clear) begin
            A <= 0;
            B <= 0;
            Rout <= 0;
            OVR <= 0;
        end
        else begin
            if (InA)
                A <= X;
            if (InB)
                B <= X;
            if (Out) begin
                Rout <= Result;
                OVR <= (Add_Subtract == 0) ?
                       ((A[7] == B[7]) && (Result[7] != A[7])) :
                       ((A[7] != B[7]) && (Result[7] != A[7]));
            end
        end
    end

endmodule