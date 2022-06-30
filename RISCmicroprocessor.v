`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.03.2022 16:29:45
// Design Name: 
// Module Name: b
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



//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:27:53 03/28/2022 
// Design Name: Rakesh Kumar Verma
// Module Name:    g 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module risc_pipelined(clk,reset,instruction,pc_out1,pc_out1_s1,instruction_s1,pc,pc_out1_s2,extended_32,extended_32_s2,read_data1,read_data2,read_data1_s2,read_data2_s2,
read_data2_s3,read_data3_s4,read_data3,instruction_s2_a,instruction_s2_b,ALU_result_s3,ALU_result_s4,ALU_result,ALUCtrl,write_data,write_data_s4,alu_in2,write_reg,write_reg_s3,
write_reg_s4,rs_s2,rt_s2,fwa,fwb,alu1,alu2,final_data);
input clk,reset;
output instruction,pc_out1,pc_out1_s1,instruction_s1,pc,pc_out1_s2,extended_32,extended_32_s2,read_data1,read_data2,read_data1_s2,read_data2_s2,read_data2_s3,read_data3_s4
,read_data3,instruction_s2_a,instruction_s2_b,ALU_result_s3,ALU_result_s4,ALU_result,ALUCtrl,write_data,write_data_s4,alu_in2,write_reg,write_reg_s3,write_reg_s4,rs_s2,rt_s2,
fwa,fwb,alu1,alu2,final_data;
wire [31:0]instruction,pc_out1,pc_out1_s1,instruction_s1;
wire  [31:0]pc;
wire [31:0]pc_out1_s2;
wire [31:0]extended_32,extended_32_s2,read_data1,read_data2,read_data1_s2,read_data2_s2,read_data2_s3;
wire [31:0] read_data3_s4,read_data3;
wire [4:0]instruction_s2_a,instruction_s2_b;
wire [31:0]ALU_result_s3,ALU_result_s4,ALU_result;
wire [3:0]ALUCtrl;


wire [31:0]write_data,write_data_s4,alu_in2;
//wire [4:0]instruction_s2_a,instruction_s2_b;
wire [4:0]write_reg,write_reg_s3,write_reg_s4;
wire [4:0] rs_s2,rt_s2;
wire [1:0]fwa,fwb;
wire [31:0]alu1,alu2,final_data;
//initial pc = 0;
//------------------------------------  stage 1
initialise i(reset, clk,pc,pc_out1);
instruction_mem im(clk,pc,instruction);
add1 a1(pc,pc_out1);
dff1 d1(clk,pc_out1,instruction,pc_out1_s1,instruction_s1);
//------------------------------------  stage 2
wire RegDst,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUOp1,ALUOp0,RegWrite_s4,RegDst_s2,ALUSrc_s2,MemtoReg_s2,RegWrite_s2,MemRead_s2,MemWrite_s2,Branch_s2,ALUOp1_s2,
ALUOp0_s2,RegWrite_s3,MemWrite_s3,MemtoReg_s3,MemRead_s3,MemtoReg_s4;
control ctrl(instruction_s1,RegDst,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUOp1,ALUOp0);
Register_mem rm(clk,instruction_s1[25:21],instruction_s1[20:16],write_reg_s4,write_data_s4,read_data1,read_data2,RegWrite_s4);
sign_extend snext(instruction_s1[15:0],extended_32);
dff2 d2(instruction_s1[25:21],instruction_s1[20:16],rs_s2,rt_s2,clk,RegDst,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUOp1,ALUOp0,
RegDst_s2,ALUSrc_s2,MemtoReg_s2,RegWrite_s2,MemRead_s2,MemWrite_s2,Branch_s2,ALUOp1_s2,ALUOp0_s2,pc_out1_s1,pc_out1_s2,extended_32,extended_32_s2,
        instruction_s1[20:16],instruction_s1[15:11],instruction_s2_a,instruction_s2_b,read_data1,read_data2,read_data1_s2,read_data2_s2);
//------------------------------------  stage 3
mux1 m1(instruction_s2_a,instruction_s2_b,RegDst_s2,write_reg);

ALU_control ac(extended_32_s2[5:0],ALUOp1_s2,ALUOp0_s2,ALUCtrl);

forward_1 f1(rs_s2,rt_s2,write_reg_s3,RegWrite_s3,fwa,fwb,write_reg_s4,RegWrite_s4);
muxfa1 mfa1(read_data1_s2,ALU_result_s3,write_data_s4,fwa,alu1);

muxfa2 mfa2(read_data2_s2,ALU_result_s3,write_data_s4,fwb,alu2);

mux2 m2(alu2,extended_32_s2,ALUSrc_s2,alu_in2);
ALU alu(clk,alu1,alu_in2,ALUCtrl,ALU_result);
dff3 d3(clk,ALU_result,write_reg,read_data2_s2,MemWrite_s2,MemtoReg_s2,MemRead_s2,ALU_result_s3,write_reg_s3,read_data2_s3,MemWrite_s3,MemtoReg_s3,MemRead_s3,RegWrite_s2,RegWrite_s3);

//-------------------------------------   stage 4
data_memory dm(clk,MemWrite_s3,MemRead_s3,ALU_result_s3,read_data2_s3,read_data3);
dff4 d4(clk,MemtoReg_s3,MemtoReg_s4,read_data3,read_data3_s4,ALU_result_s3,ALU_result_s4,write_reg_s3,write_reg_s4,RegWrite_s3,RegWrite_s4);

//-----------------------------------    stage 5

mux3 m3(read_data3_s4,ALU_result_s4,MemtoReg_s4,write_data_s4);
endmodule

module initialise (input reset ,input clk,output reg [31:0]pc,input [31:0]pc_out1);
always @(posedge clk) begin 
if(reset) pc=0;
else 
    pc=pc_out1;

end
endmodule

module instruction_mem(input clk,input [31:0]address,output reg [31:0]instruction);

wire  [0:31]mem[31:0];

assign mem[0] = 32'b000000_00010_00010_00011_00000_100001;
assign mem[4] = 32'b000000_00100_00001_00001_00000_011011;
assign mem[8] = 32'b000000_00011_00010_00100_00000_100001;
assign mem[12] = 32'b000000_00001_00010_00000_00000_011011;
assign mem[16] = 32'b000000_00110_00110_00000_00000_011001;
assign mem[20] = 32'b000000_00001_00010_00011_00000_100100;
assign mem[24] = 32'b000000_00001_00010_00011_00000_100010;
assign mem[28] = 32'b000000_00001_00010_00011_00000_100000;

always@(*) begin 
     instruction = mem[address];
end

endmodule

module add1(input [31:0]pc,output [31:0]pc_out1);

assign pc_out1 = pc+4;

endmodule

module dff1 (input clk,input [31:0]pc_out1,input [31:0]instruction,output reg [31:0]pc_out1_s1,output reg [31:0]instruction_s1);

always @(posedge clk) begin 
    pc_out1_s1 <= pc_out1;
    instruction_s1 <= instruction;
end

endmodule

module control (input [31:0]instruction,output reg RegDst,output reg  ALUSrc,output reg MemtoReg,output reg RegWrite, 
                output reg MemRead,output reg MemWrite,output reg Branch,output reg ALUOp1,output reg ALUOp0);

always @(instruction) begin 
case(instruction[31:26])

6'b000000: begin 
		RegDst  =1;
		ALUSrc = 0;
		MemtoReg = 0;
		RegWrite = 1;
		MemRead  = 0;
		MemWrite = 0;
		Branch = 0;
		ALUOp1 = 1;
		ALUOp0 = 0;
	end
6'b100011: begin 
		RegDst  =1;
		ALUSrc = 0;
		MemtoReg = 0;
		RegWrite = 1;
		MemRead  = 0;
		MemWrite = 0;
		Branch = 0;
		ALUOp1 = 1;
		ALUOp0 = 0;
	end
6'b101011: begin 
		RegDst  =1;
		ALUSrc = 0;
		MemtoReg = 0;
		RegWrite = 1;
		MemRead  = 0;
		MemWrite = 0;
		Branch = 0;
		ALUOp1 = 1;
		ALUOp0 = 0;
	end
6'b000100: begin 
		RegDst  =1;
		ALUSrc = 0;
		MemtoReg = 0;
		RegWrite = 1;
		MemRead  = 0;
		MemWrite = 0;
		Branch = 0;
		ALUOp1 = 1;
		ALUOp0 = 0;
	end



endcase
end

endmodule

module Register_mem (input clk,input [4:0]read_reg1,input [4:0]read_reg2,input [4:0]write_reg,
                     input [31:0]write_data,output reg [31:0]read_data1,output reg [31:0]read_data2,input RegWrite);

reg [31:0]reg_mem[31:0];
reg [31:0]i;
initial begin 
for (i = 0; i < 32; i=i+1) begin 
     reg_mem[i] = i;
end

end

always @(*) begin 

     read_data1 = reg_mem[read_reg1];
     read_data2 = reg_mem[read_reg2]; 
     if(RegWrite) begin
             reg_mem[write_reg ] = write_data;
end
end

endmodule

module sign_extend(input [15:0]a,output [31:0]b);

assign b = {{16{a[15]}},a};

endmodule

module dff2(input [4:0]sa,input [4:0]sb,output reg [4:0]rs_s2,output reg [4:0]rt_s2,input clk,
         input RegDst,input ALUSrc,input MemtoReg,input RegWrite,input MemRead,input MemWrite,input Branch,
	input ALUOp1,input ALUOp0,output reg RegDst_s2,output reg  ALUSrc_s2,output reg  MemtoReg_s2,
        output reg  RegWrite_s2,output reg  MemRead_s2,output reg  MemWrite_s2,output reg  Branch_s2,output  reg ALUOp1_s2,
        output reg  ALUOp0_s2,input  [31:0]pc_out1_s1,output reg [31:0]pc_out1_s2,input [31:0] extended_32,output reg  [31:0] extended_32_s2,
        input [4:0]instruction_a,input [4:0]instruction_b,output reg [4:0]instruction_s2_a,output reg [4:0]instruction_s2_b,
        input [31:0] read_data1,input [31:0] read_data2,output reg [31:0] read_data1_s2,output reg [31:0] read_data2_s2);

always @(posedge clk) begin 
     rs_s2<=sa;
     rt_s2<=sb;
     RegDst_s2<=RegDst;
     ALUSrc_s2<=ALUSrc;
     MemtoReg_s2<=MemtoReg;
     RegWrite_s2<=RegWrite;
     MemRead_s2<=MemRead;
     MemWrite_s2<=MemWrite;
     Branch_s2<=Branch;
     ALUOp1_s2<=ALUOp1;
     ALUOp0_s2<=ALUOp0;
     extended_32_s2<=extended_32;
     instruction_s2_a <=instruction_a;
     instruction_s2_b<=instruction_b;
     read_data1_s2<=read_data1;
     read_data2_s2<=read_data2;
     pc_out1_s2<=pc_out1_s1;
end

endmodule

//------------------------------------------------------ stage 3

module mux1(input [4:0]a,input [4:0]b,input sel,output [4:0]c);
assign c = (sel)?b:a;
endmodule

module ALU_control (input [5:0]a,input ALUOp1,input ALUOp0,output [3:0]ALUCtrl);
assign ALUCtrl = (({ALUOp1,ALUOp0}==2'b10))?((a == 6'b100001)?4'b0010:(a == 6'b100010)?4'b0110:(a == 6'b100100)?4'b0000:(a==6'b100101)?4'b0001:(a == 6'b011011)?4'b0100:4'b0011):4'bz;

endmodule


module mux2 (input [31:0]read_data2,input [31:0]extended32,input ALUSrc,output [31:0]alu_in2);

assign alu_in2 = (ALUSrc)?extended32:read_data2;

endmodule

module ALU (input clk,input [31:0]read_data1,input [31:0]alu_in2,input [3:0]ALUCtrl,output reg [31:0]ALU_output);

always @(ALUCtrl,read_data1,alu_in2) begin 
case(ALUCtrl)
     4'b0010: ALU_output = read_data1+alu_in2; 
     4'b0110: ALU_output = read_data1-alu_in2;
     4'b0000: ALU_output = read_data1 & alu_in2;
     4'b0001: ALU_output = read_data1 | alu_in2;
     4'b0011: ALU_output = multiplier(read_data1, alu_in2);
     4'b0100:begin ALU_output = div(read_data1, alu_in2);end
endcase


$display("control = ",ALUCtrl, " result = ",ALU_output);
end


function [31:0]multiplier(input [31:0]a,input [31:0]b);
parameter WIDTH = 32;
reg [WIDTH-1:0]temp;
reg [WIDTH-1:0]m;
reg [WIDTH-1:0]r;
reg [WIDTH*2:0]A,S,P;

begin 
     $displayb("MULTIPLICAITN",a,"-----> ", b);
     m = 32'b11111_11111_11111_11111_11111_11111_11^a;
     m = m+1;
     A = {a,33'b0};
     S = {m,33'b0};
     P = {32'b0,b,1'b0};
     repeat(WIDTH) begin
          if(P[1:0]==0)begin 
               P = {P[64],P[64:1]};
          end
          else if(P[1:0]==1)begin 
               P=P+A;
               P = {P[64],P[64:1]};

          end
          else if(P[1:0]==2)begin 
               P = P+S;
               P = {P[64],P[64:1]};
          end
          else if(P[1:0]==3)begin 
               P = {P[64],P[64:1]};
          end
     end
     multiplier = P[33:1];
end

endfunction

function [31:0]div(input [31:0]A,input [31:0]B);
    //the size of input and output ports of the division module is generic.
    parameter WIDTH = 32;
    //input and output ports.
    
    reg [WIDTH-1:0] Res;
    //internal variables    
    //reg [WIDTH-1:0] Res = 0;
    reg [WIDTH-1:0] a1,b1;
    reg [WIDTH:0] p1;   
    integer i; 
    begin
$display("-------------",A,B);
    Res = 0;
    //initialize the variables.
        a1 = A;
        b1 = B;
        p1= 0;
        for(i=0;i < WIDTH;i=i+1)    begin //start the for loop
            p1 = {p1[WIDTH-2:0],a1[WIDTH-1]};
            a1[WIDTH-1:1] = a1[WIDTH-2:0];
            p1 = p1-b1;
            if(p1[WIDTH-1] == 1)    begin
                a1[0] = 0;
                p1 = p1+b1;  
                   end
            else
                a1[0] = 1;
        end
        div = a1;   
    end 

endfunction
endmodule 





module dff3 (input clk,input [31:0]ALU_result,input [4:0]write_reg,input [31:0]read_data2_s2, 
            input MemWrite_s2,input MemtoReg_s2,input MemRead_s2,output reg [31:0]ALU_result_s3,output  reg [4:0] write_reg_s3,
            output reg [31:0]read_data2_s3,output reg  MemWrite_s3,output reg MemtoReg_s3,output reg MemRead_s3,input RegWrite_s2,output reg RegWrite_s3);

always @(posedge clk) begin 
     ALU_result_s3<=ALU_result;
     write_reg_s3<=write_reg;
     read_data2_s3<=read_data2_s2;
     MemWrite_s3<=MemWrite_s2;
     MemtoReg_s3<=MemtoReg_s2;
     MemRead_s3<=MemRead_s2;
     RegWrite_s3<=RegWrite_s2;
     $monitorb("________________________________________________________",ALU_result);
end
endmodule

// --------------------------------  stage 4

module forward_1 (input [4:0]rs_s2,input [4:0]rt_s2,input [4:0]write_reg_s3,input RegWrite_s3,output reg [1:0]fwda,output reg [1:0]fwdb,input [4:0]write_reg_s4,input RegWrite_s4);
//
always @(write_reg_s3,rs_s2,rt_s2) begin 
//
fwda = 0;
fwdb = 0;
if((RegWrite_s3 ==1) && (write_reg_s3 !=0) &&(write_reg_s3 == rs_s2) )begin 
    fwda = 2'b10;
end 
if((RegWrite_s3 ==1) && (write_reg_s3 !=0) &&(write_reg_s3 == rt_s2) )begin 
    fwdb = 2'b10;
end 
if((RegWrite_s4 ==1) && (write_reg_s4 !=0) &&(write_reg_s4 == rs_s2) && !((RegWrite_s3 ==1) && (write_reg_s3 !=0) &&(write_reg_s3 == rs_s2) ))begin 
    fwda = 2'b01;
end 
if((RegWrite_s3 ==1) && (write_reg_s3 !=0) &&(write_reg_s4 == rt_s2) && !((RegWrite_s3 ==1) && (write_reg_s3 !=0) &&(write_reg_s3 == rt_s2) ) )begin 
    fwdb = 2'b01;
end 


end
//
endmodule


module muxfa2 (input [31:0]read_data2_s2,input [31:0]ALU_result_s3,input [31:0]final_data,input [1:0]fwb,output reg [31:0]alu2);

always @(*) begin 

if(fwb==2)begin 
alu2 = ALU_result_s3;
end
else if(fwb==1)
alu2 = final_data;
else alu2 = read_data2_s2;
end

endmodule


module muxfa1 (input [31:0]read_data1_s2,input [31:0]ALU_result_s3,input [31:0] final_data,input [1:0]fwa,output reg  [31:0]alu1);
always @(*) begin 
if(fwa==2)begin 
alu1 = ALU_result_s3;
end
else if(fwa==1)
alu1 = final_data;
else alu1 = read_data1_s2;
end
endmodule


module data_memory (input clk,input MemWrite,input MemRead,input [31:0]ALU_output,input [31:0]read_data2,output reg [31:0]read_data);
reg [31:0]mem[0:232];
reg [232:0]i;
initial begin 
	for(i = 0; i < 232 ; i = i+1) begin 
		mem[i] = 0;
	end
end

always @(posedge clk) begin 

     if(MemRead) begin 
          read_data = mem[ALU_output];
     end
     if(MemWrite) begin 
          mem[ALU_output] = read_data2;
     end
end
endmodule

module dff4 (input clk,input MemtoReg_s3,output reg MemtoReg_s4,input [31:0]read_data3,output reg [31:0]read_data3_s4,
             input [31:0]ALU_result_s3,output reg [31:0]ALU_result_s4,input [4:0]write_reg_s3,output reg [4:0]write_reg_s4,input RegWrite_s3,output reg RegWrite_s4);

always @(posedge clk) begin 
     MemtoReg_s4<=MemtoReg_s3;
     read_data3_s4<=read_data3;
     ALU_result_s4<=ALU_result_s3;
     
     write_reg_s4<= write_reg_s3;
     RegWrite_s4<=RegWrite_s3;

end
endmodule

//----------------------------------------- stage 5

module mux3 (input [31:0]read_data,input [31:0]ALU_output,input MemtoReg,output [31:0]write_data);

assign write_data = (MemtoReg)?read_data:ALU_output;

endmodule
