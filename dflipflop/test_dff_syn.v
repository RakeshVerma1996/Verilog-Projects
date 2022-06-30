`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2021 12:40:16 AM
// Design Name: 
// Module Name: test_dff_syn
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


module test_dff_syn();
 reg clk;
 reg reset;
 reg d;
 reg en;
 wire q;
 wire qb;
 dff_syn Dflipflop(.clk(clk), .reset(reset),.d(d),.en(en),.q(q), .qb(qb));
           
   initial 
   begin
    clk = 0;  reset = 1;      // not defigning the value of 'd'
      #50
    clk = 0; reset = 1; d=1'b1;
    #50
    clk =0; reset=0; d=1'b1;
    #50
    clk =1; reset =0; d=1'b1; en=0;
    #50
    clk =1; reset =0; d=1'b1; en=1;
   end      
endmodule

