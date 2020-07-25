`timescale 1ns / 1ps
`include "defines/defines.svh"
module dispatch_iq_regs(
    input clk,
    input rst,
    input flush,
    input rs_alu_ready, 
    input rs_mdu_ready,
    input rs_lsu_ready, 
    input rs_alu_wen_0_i, rs_alu_wen_1_i, 
    input rs_mdu_wen_0_i, 
    input rs_lsu_wen_0_i, rs_lsu_wen_1_i,
    input ALU_Queue_Meta rs_alu_dout_0_i, rs_alu_dout_1_i,
    input MDU_Queue_Meta rs_mdu_dout_0_i,
    input LSU_Queue_Meta rs_lsu_dout_0_i, rs_lsu_dout_1_i,
    output reg rs_alu_wen_0, rs_alu_wen_1, 
    output reg rs_mdu_wen_0, 
    output reg rs_lsu_wen_0, rs_lsu_wen_1,
    output ALU_Queue_Meta rs_alu_dout_0, rs_alu_dout_1,
    output MDU_Queue_Meta rs_mdu_dout_0,
    output LSU_Queue_Meta rs_lsu_dout_0, rs_lsu_dout_1
    );
always @(posedge clk)   begin
    if(rst) begin
        rs_alu_wen_0    <= 0;
        rs_alu_wen_1    <= 0;
        rs_mdu_wen_0    <= 0;
        rs_lsu_wen_0    <= 0;
        rs_lsu_wen_1    <= 0;
        rs_alu_dout_0   <= 0;
        rs_alu_dout_1   <= 0;
        rs_mdu_dout_0   <= 0;
        rs_lsu_dout_0   <= 0;
        rs_lsu_dout_1   <= 0;
    end else begin
        rs_alu_wen_0    <= rs_alu_ready ? rs_alu_wen_0_i : rs_alu_wen_0;
        rs_alu_wen_1    <= rs_alu_ready ? rs_alu_wen_1_i : rs_alu_wen_1;
        rs_mdu_wen_0    <= rs_mdu_ready ? rs_mdu_wen_0_i : rs_mdu_wen_0;
        rs_lsu_wen_0    <= rs_lsu_ready ? rs_lsu_wen_0_i : rs_lsu_wen_0;
        rs_lsu_wen_1    <= rs_lsu_ready ? rs_lsu_wen_1_i : rs_lsu_wen_1;

        rs_alu_dout_0    <= rs_alu_ready ? rs_alu_dout_0_i : rs_alu_dout_0 ;
        rs_alu_dout_1    <= rs_alu_ready ? rs_alu_dout_1_i : rs_alu_dout_1 ;
        rs_mdu_dout_0    <= rs_mdu_ready ? rs_mdu_dout_0_i : rs_mdu_dout_0 ;
        rs_lsu_dout_0    <= rs_lsu_ready ? rs_lsu_dout_0_i : rs_lsu_dout_0 ;
        rs_lsu_dout_1    <= rs_lsu_ready ? rs_lsu_dout_1_i : rs_lsu_dout_1 ;
    end
end
endmodule
