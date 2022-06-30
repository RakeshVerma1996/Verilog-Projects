`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2021 12:38:42 AM
// Design Name: 
// Module Name: dff_syn
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


module dff_syn(clk,reset,d,en,q,qb);     // defining the ports
  input      clk;                         //defining the ports to be input or output
  input      reset;
  input      d;
  input      en;
  output     q;
  output     qb;

  reg        q;    // in behavioral designing output declared to be reg type 

  assign qb = ~q;

  always @(posedge clk,posedge reset,posedge en)
  begin
    if (reset) 
    begin
       q <= 1'b0;
    end 
    else if(en)
    begin
      q <= d;
    end
  end
endmodule
