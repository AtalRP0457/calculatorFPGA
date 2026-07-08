module halfADDER(
    output s,
    output cout,
    input a,
    input b
);

and (cout,a,b);
xor (s,a,b);

endmodule