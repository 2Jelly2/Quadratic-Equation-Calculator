`timescale 1ns / 1ps

module QuadCalc_TB();

reg clock;
reg reset;
reg [15:0] a;       //a, b, c
reg [15:0] b;
reg [15:0] c;
wire [15:0] root1;  //roots
wire [15:0] root2;
wire [1:0] state;	//number of roots

initial
begin
    clock <= 1;
    reset <= 1;
    a <= 1;
    b <= -2;
    c <= 1;
    #100			//change slowly
    a <= 1;
    b <= -2;
    c <= 3;
    #100
    a <= 1;
    b <= -2;
    c <= -3; 
    #100
    a <= 1;
    b <= -2;
    c <= -35;
    #60
    reset = 0;		//reset activated
    #40
    a <= 3;
    b <= -13;
    c <= -30;
    #50
    reset = 1;  	//reset deactivated
    #50
    a <= 4;
    b <= -28;
    c <= 49;
    #100
    a <= 2;
    b <= -13;
    c <= -15;
    #100
    a <= 3;
    b <= -47;
    c <= 170;
    #100
    a <= 3;
    b <= -47;
    c <= -170;
    #100
    a <= 2;
    b <= -9;
    c <= -81;
    #100
    $finish;
end

always #5
begin
    clock = ~clock;
end

QuadCalc U0(
    .CLK(clock),
    .RST(reset),
    .A(a),
    .B(b),
    .C(c),
    .RT1(root1),
    .RT2(root2),
    .ST(state)
    );

endmodule
