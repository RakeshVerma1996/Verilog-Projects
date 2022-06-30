`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/10/2021 08:07:50 PM
// Design Name: 
// Module Name: test_UP_DOWN_WITH_SR_to_JK
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


module test_UP_DOWN_WITH_SR_to_JK();
reg clk=0,rst=1;
  wire[3:0] q;
  UP_DOWN_WITH_SR_to_JK updowncounter(clk,rst,q);

 initial 
       repeat(40)
        #1
         clk = ~clk;
        initial 
        #1 
        rst=0;

endmodule










