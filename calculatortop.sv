module calculatortop (
    input  logic        MAX10_CLK1_50, 
    input  logic [1:0]  KEY,           
    input  logic [3:0]  row,           
    output logic [3:0]  col,           
    output logic [0:6]  HEX0, HEX1,    
    output logic [0:6]  HEX2, HEX3,    
    output logic [9:0]  LEDR           
);

    wire [3:0] keypad_val;
    wire trig;

    wire [7:0] IU_data;
    wire [7:0] AU_data;

    wire LdA, LdB, LdR;
    wire AddSub;
    wire sel;
    wire clear_IU;

    wire ZERO, OVR;
    wire INVALID;

    keypad_input IU (
        .clk(MAX10_CLK1_50),
        .reset(KEY[0]),
        .iu_clear(clear_IU | ~KEY[1]),
        .row(row),
        .col(col),
        .keypad_val(keypad_val),
        .trig(trig),
        .data_out(IU_data)
    );

    CU control_unit (
        .clk(MAX10_CLK1_50),
        .reset(KEY[0]),
        .trig(trig),
        .val(keypad_val),
        .LoadX(LdA),
        .LoadY(LdB),
        .AddSub(AddSub),
        .LoadR(LdR),
        .IUAU(sel),
        .clearEntry(clear_IU),
        .INVALID(INVALID)
    );

    AU8 AU (
        .clk(MAX10_CLK1_50),
        .Clear(~KEY[0]),
        .X(IU_data),
        .Add_Subtract(AddSub),
        .InA(LdA),
        .InB(LdB),
        .Out(LdR),
        .Rout(AU_data),
        .OVR(OVR),
        .ZERO(ZERO)
    );

    wire [7:0] display_data;
    assign display_data = sel ? AU_data : IU_data;

    OU OU (
        .data_in(display_data),
        .INVALID(INVALID),
        .HEX0(HEX0),
        .HEX1(HEX1),
        .HEX2(HEX2),
        .HEX3(HEX3)
    );

    assign LEDR[8] = ZERO;
    assign LEDR[9] = OVR;
    assign LEDR[7:0] = 8'b0;

endmodule