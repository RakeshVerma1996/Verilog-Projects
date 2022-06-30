`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2021 01:53:18 AM
// Design Name: 
// Module Name: test_SR_FLIP
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


module test_SR_FLIP();
wire q, qbar;
	reg clk,reset;
	reg [1:0] sr;

	SR_FLIP SRFLIPFLOP(q,qbar,clk,reset,sr);
	initial
	begin
	reset=1;sr=2'b00;clk=1;
	#50
	reset=0;sr=2'b01;
	#50
	reset=0;sr=2'b10;
	#50
	reset=0;sr=2'b11;
	end
endmodule
