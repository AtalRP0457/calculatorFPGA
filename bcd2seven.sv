//HEX to seven-segment decoder. Active low output.
module bcd2seven(
	input logic [3:0] bcd,
	output logic [0:6] display
);
	 always @(*) begin
			case (bcd)
					4'd0: display = 7'b0000001; //0
					4'd1: display = 7'b1001111; //1
					4'd2: display = 7'b0010010; //2
					4'd3: display = 7'b0000110; //3
					4'd4: display = 7'b1001100; //4
					4'd5: display = 7'b0100100; //5
					4'd6: display = 7'b0100000; //6
					4'd7: display = 7'b0001111; //7
					4'd8: display = 7'b0000000; //8
					4'd9: display = 7'b0001100; //9
					default : display = 7'b1111111;
					
			endcase
		end
endmodule
