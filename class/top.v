module top(
    input [9:0] sw,
    output [13:0] led
);

    half_sub sub(
        .A(sw[0]),
        .B(sw[1]),
        .Y(led[0]),
        .Borrow(led[1])
    );

    ones_compliment ones(
        .A(sw[5:2]),
        .B(sw[9:6]),
        .Y(led[5:2])
    );

    twos_compliment twos(
        .A(sw[9:2]),
        .Y(led[13:6])
    );

endmodule