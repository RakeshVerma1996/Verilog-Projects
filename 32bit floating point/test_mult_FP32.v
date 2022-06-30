`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/10/2021 01:13:12 PM
// Design Name: 
// Module Name: test_mult_FP32
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module test_mult_FP32();

reg [31:0] a,b;
wire exception,overflow,underflow;
wire [31:0] res;

reg clk = 1'b1;
mult_FP32 multiplier(a,b,exception,overflow,underflow,res);

always clk = #5 ~clk;

initial
begin
iteration (32'h0200_0000,32'h0200_0000,1'b0,1'b0,1'b0,32'h0000_0000,`__LINE__);

iteration (32'h4234_851F,32'h427C_851F,1'b0,1'b0,1'b0,32'h4532_10E9,`__LINE__); // 45.13 * 63.13 = 2849.0569;

iteration (32'h4049_999A,32'hC166_3D71,1'b0,1'b0,1'b0,32'hC235_5062,`__LINE__); //3.15 * -14.39 = -45.3285

iteration (32'hC152_6666,32'hC240_A3D7,1'b0,1'b0,1'b0,32'h441E_5375,`__LINE__); //-13.15 * -48.16 = 633.304

iteration (32'h4580_0000,32'h4580_0000,1'b0,1'b0,1'b0,32'h4B80_0000,`__LINE__); //4096 * 4096 = 16777216

iteration (32'h3ACA_62C1,32'h3ACA_62C1,1'b0,1'b0,1'b0,32'h361F_FFE7,`__LINE__); //0.00154408081 * 0.00154408081 = 0.00000238418

iteration (32'h0000_0000,32'h0000_0000,1'b0,1'b0,1'b0,32'h0000_0000,`__LINE__); // 0 * 0 = 0;

iteration (32'hC152_6666,32'h0000_0000,1'b0,1'b0,1'b0,32'h441E_5375,`__LINE__); //-13.15 * 0 = 0;

iteration (32'h7F80_0000,32'h7F80_0000,1'b1,1'b1,1'b0,32'h0000_0000,`__LINE__); 

$stop;

end

task iteration(
input [31:0] op_a,op_b,
input Expected_Exception,Expected_Overflow,Expected_Underflow,
input [31:0] Expected_result,
input integer linenum 
);
begin
@(negedge clk)
begin
	a = op_a;
	b = op_b;
end

@(posedge clk)
begin
if ((Expected_result == res) && (Expected_Exception == exception) && (Expected_Overflow == overflow) && (Expected_Underflow == underflow))
	$display ("Success : %d",linenum);

else
	$display ("Failed : Expected_result = %h, Result = %h, \n Expected_Exception = %d, Exception = %d,\n Expected_Overflow = %d, Overflow = %d, \n Expected_Underflow = %d, Underflow = %d - %d \n ",Expected_result,res,Expected_Exception,exception,Expected_Overflow,overflow,Expected_Underflow,underflow,linenum);
end
end
endtask
endmodule

