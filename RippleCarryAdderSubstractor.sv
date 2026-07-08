
module RippleCarryAdderSubstractor ( //name the module
	input [7:0] A, B, //declare input ports
	input add_subtract, //Select mode Add: 0 , Substract : 1
	output [7:0] S, //Output Result (sum or difference)
	output Cout, OVR, NEG, ZERO
	); //declare carry-out port
	
	logic [8:0] C; //declare internal nets for the carries
	logic [7:0] b_xor; // For the XORed values of the B inputs
		assign C[0] = add_subtract; //if c0=1, its adds the "1" for 2's complement 
		
		
		//conditional inversion
		assign b_xor [0] = B[0] ^ add_subtract;
		assign b_xor [1] = B[1] ^ add_subtract;
		assign b_xor [2] = B[2] ^ add_subtract;
		assign b_xor [3] = B[3] ^ add_subtract;
		assign b_xor [4] = B[4] ^ add_subtract;
		assign b_xor [5] = B[5] ^ add_subtract;
		assign b_xor [6] = B[6] ^ add_subtract;
		assign b_xor [7] = B[7] ^ add_subtract;
//instantiate the full adder module for each stage of the ripple carry adder
	FAbehavSV s0 (A[0], b_xor[0], C[0], S[0], C[1]); //stage 0
	FAbehavSV s1 (A[1], b_xor[1], C[1], S[1], C[2]); //stage 1
	FAbehavSV s2 (A[2], b_xor[2], C[2], S[2], C[3]); //stage 2
	FAbehavSV s3 (A[3], b_xor[3], C[3], S[3], C[4]); //stage 3
	FAbehavSV s4 (A[4], b_xor[4], C[4], S[4], C[5]);
	FAbehavSV s5 (A[5], b_xor[5], C[5], S[5], C[6]);
	FAbehavSV s6 (A[6], b_xor[6], C[6], S[6], C[7]);
	FAbehavSV s7 (A[7], b_xor[7], C[7], S[7], C[8]);
	
	assign Cout = C[8]; //rename carry-out port
	assign OVR = C[8] ^ C[7]; //Overflow
	assign NEG = S[7]; //Sign Bit
	assign ZERO = ~(S[0]|S[1]|S[2]|S[3]|S[4]|S[5]|S[6]|S[7]); //Zero Detect
	
endmodule
