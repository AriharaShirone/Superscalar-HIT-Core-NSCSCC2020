`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/09 20:03:34
// Design Name: 
// Module Name: IF0_1_reg
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
`include "../defs.sv"

module IF0_1_reg(
    input wire clk,
    input wire rst,

    Ctrl.slave          ctrl_if0_1_regs,
    
    IF0_Regs.regs       if0_regs,

    Regs_NLP.regs       regs_nlp,
    Regs_BPD.regs       regs_bpd,
    Regs_ICache.regs    regs_iCache,

    NLP_IF0.if0         nlp_if0,
    IF3Redirect.if0     if3_0,
    BackendRedirect.if0 backend_if0
);

    logic           headIsDS;
    logic           dsAddr;
    logic [31:0]    PC;

    assign if0_regs.PC      = PC;
    assign regs_nlp.PC      = PC;
    assign regs_bpd.PC      = PC;
    assign regs_iCache.PC   = PC;

    assign ctrl_if0_1_regs.pauseReq     = `FALSE;

    assign regs_iCache.inst0.nlpInfo    = nlp_if0.nlpInfo0;
    assign regs_iCache.inst1.nlpInfo    = nlp_if0.nlpInfo1;

    always_ff @ (posedge clk) begin
        if(rst || ctrl_if0_1_regs.flush) begin
            PC          <=  32'h0;
            headIsDS    <=  `FALSE;
        end else if(backend_if0.redirect && backend_if0.valid) begin
            PC          <=  backend_if0.redirectPC;
            headIsDS    <=  `FALSE;
        end else if(if3_0.redirect) begin
            PC          <=  if3_0.redirectPC;
            headIsDS    <=  `FALSE;
        end else if(headIsDS) begin
            PC          <=  dsAddr;
            headIsDS    <=  `FALSE;
        end else if(nlp_if0.nlpInfo0.valid && nlp_if0.nlpInfo0.taken) begin
            PC          <=  nlp_if0.nlpInfo0.target;
            headIsDS    <=  `FALSE;
        end else if(nlp_if0.nlpInfo1.valid && nlp_if0.nlpInfo1.taken) begin
            PC          <=  if0_regs.nPC;
            headIsDS    <=  `TRUE;
            dsAddr      <=  nlp_if0.nlpInfo1.target;
        end else if(ctrl_if0_1_regs.pause) begin
            PC          <=  PC;
            headIsDS    <=  headIsDS;
            dsAddr      <=  dsAddr;
        end else begin
            PC          <=  if0_regs.nPC;
            headIsDS    <=  `FALSE;
        end
    end

endmodule
