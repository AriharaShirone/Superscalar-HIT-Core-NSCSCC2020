`timescale 1ns / 1ps
`include "../defs.sv"
`include "../defines/defines.svh"

module Predecoder(
    input   logic [31:0]    pc,
    input   logic [31:0]    inst,
    input   logic           valid,
    output  logic           isJ,
    output  logic           isBr,
    output  logic           jr,
    output  logic [31:0]    target
);

    always_comb begin
        if(valid) begin
            casez (inst)
                // quick redirect
                `J, `JAL: begin
                    isJ     = `TRUE;    // must redirect
                    isBr    = `FALSE;
                    jr      = `FALSE;
                    target  = {pc[31:28], inst[25:0], 2'b00};
                end
                // `BAL: begin  // BAL
                //     isJ     = `TRUE;    // must redirect, with different address
                //     isBr    = `FALSE;
                //     jr      = `TRUE;
                //     target  = pc + {{14{inst[15]}}, inst[15:0] << 2};
                // end
                // backend-redirect, predecode for wrong target or checking NLP/BPD false postive(br/normal mispredict)
                `BEQ, `BNE, `BGEZ, `BGEZAL, `BGTZ, `BLEZ, `BLTZ, `BLTZAL: begin
                    isJ     = `FALSE;  // redirect unknown;
                    isBr    = `TRUE;
                    jr      = `FALSE;
                    target  = pc + {{14{inst[15]}}, inst[15:0], 2'b00} + 4;
                end
                `JR, `JALR: begin  // JALR
                    isJ     = `TRUE;
                    isBr    = `FALSE;
                    jr      = `TRUE;    // must redirect, unless unknown target info
                    target  = 32'h00000000;
                end
                default: begin
                    isJ     = `FALSE;
                    isBr    = `FALSE;
                    jr      = `FALSE;   // don't redirect on normal instrutions
                    target  = 32'h00000000;
                end
            endcase
        end
    end

endmodule
