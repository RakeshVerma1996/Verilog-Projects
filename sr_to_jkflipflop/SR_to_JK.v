module SR_FLIP(q,qbar,clk,rst,s,r);
               output reg q;
	           output  qbar;
	           input clk, rst;
	           input  s,r;
	           assign qbar = ~q;
     always @(posedge clk)
               begin
                   if (rst)
                   q <= 1'b0;
               
               else
                 case({s,r})
                   {1'b0,1'b0}: begin q <= q;end
                   {1'b0,1'b1}: begin q <= 0; end
                   {1'b1,1'b0}: begin q <= 1; end
                   {1'b1,1'b1}: begin q <= 1'bx;end
                endcase
        end
endmodule
module and_gate(x,a,b);
input a,b;
output x;
and(x,a,b);
endmodule

module SR_to_JK(q,qbar,clk,rst,j,k);
    output q;
	output  qbar;
    input j,k,clk,rst;
SR_FLIP srflipflop(q,qbar,clk,rst,s,r);
	and_gate a1(s,j,qbar);
	and_gate a2(r,k,q);
endmodule
