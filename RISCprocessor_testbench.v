`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.03.2022 17:13:08
// Design Name: 
// Module Name: c
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



////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:10:52 03/26/2022 Rakesh Kumar Verma
// Design Name:   testbench microprocessor
// Module Name:   x.v
// Project Name:  f
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: pipelined_mipstest
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testbench();
// Inputs
	reg clk;
	reg reset;
// Output
	wire [31:0] instruction;
	wire [31:0] pc_out1;
	wire [31:0] pc_out1_s1;
	wire [31:0] instruction_s1;
	wire [31:0] pc;
	wire [31:0] pc_out1_s2;
	wire [31:0] extended_32;
	wire [31:0] extended_32_s2;
	wire [31:0] read_data1;
	wire [31:0] read_data2;
	wire [31:0] read_data1_s2;
	wire [31:0] read_data2_s2;
	wire [31:0] read_data2_s3;
	wire [4:0] instruction_s2_a;
	wire [4:0] instruction_s2_b;
	wire [31:0] ALU_result_s3;
	wire [31:0] ALU_result_s4;
	wire [31:0] ALU_result;
	wire [3:0] ALUCtrl;
	wire [31:0] write_data_s4;
	wire [31:0] alu_in2;
	wire [4:0] write_reg;
	wire [4:0] write_reg_s3;
	wire [4:0] write_reg_s4;
	wire [4:0] rs_s2;
	wire [4:0] rt_s2;
	wire [1:0] fwa;
	wire [1:0] fwb;
	wire [31:0] alu1;
	wire [31:0] alu2;
	

	risc_pipelined M1 (
		.clk(clk), .reset(reset), .instruction(instruction), .pc_out1(pc_out1), .pc_out1_s1(pc_out1_s1), .instruction_s1(instruction_s1), .pc(pc), 
		.pc_out1_s2(pc_out1_s2), .extended_32(extended_32), .extended_32_s2(extended_32_s2), .read_data1(read_data1), .read_data2(read_data2), .read_data1_s2(read_data1_s2), 
		.read_data2_s2(read_data2_s2), .read_data2_s3(read_data2_s3), .instruction_s2_a(instruction_s2_a), .instruction_s2_b(instruction_s2_b), .ALU_result_s3(ALU_result_s3), 
		.ALU_result_s4(ALU_result_s4), .ALU_result(ALU_result), .ALUCtrl(ALUCtrl), .write_data_s4(write_data_s4), .alu_in2(alu_in2), .write_reg(write_reg), .write_reg_s3(write_reg_s3), 
		.write_reg_s4(write_reg_s4), .rs_s2(rs_s2), .rt_s2(rt_s2), .fwa(fwa), .fwb(fwb), .alu1(alu1), .alu2(alu2) );

	initial 
	begin
		clk = 0;
		#4 clk=1;
    forever
        #10 clk=~clk;
    end
 
initial 
begin 
reset = 1;
#5 reset = 0;
#400
 $finish;
end
endmodule 
