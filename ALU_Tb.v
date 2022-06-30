
module ALU_Tb();
reg [31:0] a;
reg [31:0] b;
reg s0;
reg s1;
reg s2;
wire [31:0] result;

ALU_32Bit al (.a(a),.b(b),.s0(s0),.s1(s1),.s2(s2),.result(result));
         initial 
              begin

                s0=0;s1=0;s2=0;a=32'h5840;b=32'h6230;
             #100 s0=0;s1=0;s2=1;a=32'h5840;b=32'h6230;
             #100 s0=0;s1=1;s2=0;a=32'h5840;b=32'h6230;
             #100 s0=0;s1=1;s2=1;a=32'h5840;b=32'h6230;
             #100 s0=1;s1=0;s2=0;a=32'h5840;b=32'h6230;
             #100 s0=1;s1=0;s2=1;a=32'h5840;b=32'h6230;
             #100 s0=1;s1=1;s2=0;a=32'h5840;b=32'h6230; 
             #100 
             $finish;

end
endmodule
