// Twos' complement converter, 8 bits
//Y = ~A + 1
module twos_compliment(
    input [7:0] A,
    output [7:0] Y
);
    wire [7:0] inv = ~A;
    wire [7:0] c;

    genvar i;

    // Bit 0: adds the +1
    full_adder fa0(.A(inv[0]), .B(1'b1), .Cin(1'b0), .Y(Y[0]), .Cout(c[0]));

    // Bits 1-7
    generate
        for (i = 1; i < 8; i = i + 1) begin : bits
            full_adder fa(.A(inv[i]), .B(1'b0), .Cin(c[i-1]), .Y(Y[i]), .Cout(c[i]));
        end
    endgenerate
endmodule