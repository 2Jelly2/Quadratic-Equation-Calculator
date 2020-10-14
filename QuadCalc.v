`timescale 1ns / 1ps

module QuadCalc(CLK, RST, A, B, C, RT1, RT2, ST);

input CLK;
input RST;
input [15:0] A;				//a, b, c
input [15:0] B;
input [15:0] C;
output reg [15:0] RT1;		//roots
output reg [15:0] RT2;
output reg [1:0] ST;		//state, number of roots
reg [15:0] DLT;				//delta
reg SPACE;					//high impedance output
reg IMG;

always @ (posedge CLK)
begin

    if (RST == 1)			//reset deactivated
    begin
        DLT = B**2 - 4*A*C;
        if (DLT > 16'b1000000000000000)
        begin
            ST = 2'b00;		//no roots
            RT1 = (- B + (- DLT)**(0.5))/(2 * A);
            RT2 = (- B - (- DLT)**(0.5))/(2 * A);
            IMG = 1;
        end
        else if(DLT == 0)
        begin
            ST = 2'b01;		//1 root
            RT1 = (- B + DLT**(0.5))/(2 * A);
            RT2 = RT1;
            IMG = 0;
        end
        else
        begin
            ST = 2'b10;		//2 roots
            RT1 = (- B + DLT**(0.5))/(2 * A);
            RT2 = (- B - DLT**(0.5))/(2 * A);
            IMG = 0;
        end
    end
    else					//reset activated
    begin
        ST <= SPACE;
        IMG <= SPACE;
        RT1 <= SPACE;
        RT2 <= SPACE;
    end
end

endmodule