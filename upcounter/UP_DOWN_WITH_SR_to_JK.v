
module jk_flipflop(input j,k,clk,reset,output reg q);
  always @(negedge clk) begin
    if(reset)
      q<=1'b0;
    else begin
      case({j,k})
        2'b00 : q<=q;
        2'b01 : q<=1'b0;
        2'b10 : q<=1'b1;
        2'b11 : q<=~q;
      endcase
    end
  end
endmodule

module UP_DOWN_WITH_SR_to_JK(input clk,reset,output[3:0] q);

  jkfflop first(1'b1,1'b1,clk,reset,q[0]);
  
  jkfflop second(~q[3],~q[3],q[0],reset,q[1]);
  
  jkfflop third(1'b1,1'b1,q[1],reset,q[2]);
  
  jkfflop forth(q[1]&q[2],q[3],q[0],reset,q[3]);
  
endmodule

   
