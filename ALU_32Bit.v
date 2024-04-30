
//addition
module add(a,b,y);
input [31:0]a,b;
output[31:0] y;
assign y=a+b;
endmodule

//subtraction
module sub(a,b,y);
input [31:0]a,b;
output[31:0] y;
assign y=a-b;
endmodule


//32 bit Booth multiplier
module booth(out,rst,load,a,b);
  input rst,load;
  input [31:0]a,b;
  output reg [63:0]out;
  integer i;
  reg [64:0]tmp_a,s,p;

  always @(*) begin
   if(rst)
   out = 32'b0000000000000000;
   else begin
    if (load)
      tmp_a = {~a + 1'b1,33'b000000000};
      s = {a,33'b000000000};
      p = {32'b00000000,b,1'b0};
      for(i=0; i<32; i=i+1) begin
      case(p[1:0])
        2'b00: p = {p[64], p[64:1]};
        2'b01: begin
	  p = p + s;
          p = {p[64],p[64:1]};
        end
        2'b10: begin
	  p = p + tmp_a;
          p = {p[64],p[64:1]};
        end
        2'b11: p = {p[64], p[64:1]};
        default : p = 65'bxxxxxxxxxxxxxxxxx;
     endcase
  end
  out = p[64:1];
end
end
endmodule

//32-Bit AND operation
module and32(a,b,y);
input [31:0]a;
input [31:0]b;
output [31:0]y;
assign y=a&b;
endmodule

//32-bit Xor operation
module Xor1(a,b,y);
input [31:0]a;
input [31:0]b;
output [31:0]y;
assign y=a^b;
endmodule

//right shift operation
module rshift(a,b);
input[31:0] a;
output[31:0] b;
assign b=a>>1;
endmodule

//left shift operation
module lshift(a,b);
input[31:0] a;
output [31:0] b;
assign b=a<<1;
endmodule

// defining the ALU module
module ALU_32Bit(a,b,s0,s1,s2, result,rst,load);
input rst,load;
input[31:0] a,b;
input s0,s1,s2;
output[63:0] result;
reg[31:0] result;
wire[31:0]w0,w1,w2,w3,w4,w5,w6;
             add r1(a,b,w0);
             sub r2(a,b,w1);
             booth m1(w2,0,1,a,b);
             and32 g1(a,b,w3);
             Xor1 g2(a,b,w4);
             rshift op1(a,w5);
             lshift op2(a,w6);

            always@(a,b,s0,s1,s2,w0,w1,w2,w3,w4,w5,w6)
                 case ({s0,s1,s2})
                     3'b000: result<=w0; 
                     3'b001: result<=w1; 
                     3'b010: result<=w2; 
                     3'b011: result<=w3; 
                     3'b100: result<=w4; 
                     3'b101: result<=w5; 
                     3'b110: result<=w6;
                endcase
endmodule



