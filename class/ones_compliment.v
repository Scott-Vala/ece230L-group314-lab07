// Ones complement adder, 4 bits
// Two separate additions avoid a combinatorial loop
//   Stage 1: A + B (Cin = 0)
//   Stage 2: (A + B) + end-around carry c1[3]
module ones_compliment(
    input [3:0] A,
    input [3:0] B,
    output [3:0] Y
);
    wire [3:0] s1;   // A + B
    wire [3:0] c1;   // stage 1 carries
    wire [3:0] c2;   // stage 2 carries

    genvar i;

    // Stage 1
    full_adder fa0(.A(A[0]), .B(B[0]), .Cin(1'b0), .Y(s1[0]), .Cout(c1[0]));
    generate
        for (i = 1; i < 4; i = i + 1) begin : stage1
            full_adder fa(.A(A[i]), .B(B[i]), .Cin(c1[i-1]), .Y(s1[i]), .Cout(c1[i])
            );
        end
    endgenerate

    // Stage 2
    full_adder fb0(.A(s1[0]), .B(1'b0), .Cin(c1[3]), .Y(Y[0]), .Cout(c2[0]));
    generate
        for (i = 1; i < 4; i = i + 1) begin : stage2
            full_adder fb(.A(s1[i]), .B(1'b0), .Cin(c2[i-1]), .Y(Y[i]), .Cout(c2[i])
            );
        end
    endgenerate
endmodule