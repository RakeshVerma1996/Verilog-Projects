


module test_SR_to_JK();
    wire q_, q_bar;
	reg clk,rst;
	reg [1:0]JK;

	SR_to_JK srtojkflipflop(q_,q_bar,clk,rst,JK);
	always #25 clk = ~clk;

	initial
	begin
                clk = 1'b1;
                rst=1; JK=2'b00;
                #10
                rst=0;
                JK=2'b10;
                #100
                rst=0;
                JK=2'b01;
                #100
                rst=0;
                JK=2'b11;
                #100
                rst=0;
                JK=2'b00;
                #100
                rst=0;
                JK=2'b10;
                end
               
endmodule
