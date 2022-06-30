`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2021 01:45:45 AM
// Design Name: 
// Module Name: SR_FLIP
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


module SR_FLIP(q,qbar,clk,reset,sr);
	output reg q;
	output qbar;
	input clk, reset;
	input [1:0] sr;

	assign qbar = ~q;

	always @(posedge clk)
	begin
		if (reset)
			q <= 0;
		else
			case(sr)
				2'b00: q <= q;
				2'b01: q <= 0;
				2'b10: q <= 1;
				2'b11: q <= 1'bx;
			endcase
	end
endmodule

