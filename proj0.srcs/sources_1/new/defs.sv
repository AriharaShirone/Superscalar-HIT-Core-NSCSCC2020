`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/07 20:13:01
// Design Name: 
// Module Name: defs
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

`ifndef DEFINES
`define DEFINES

`define TRUE            1'b1
`define FALSE           1'b0
// `define WORD            31:0

`define IB_SIZE         16
`define IB_ADDR         3:0

typedef struct packed {
    logic   [31:0]  target;
    logic   [1:0]   bimState;
    logic           taken;
    logic           valid;
} NLPPredInfo;

typedef struct packed {
    logic   [31:0]  target;
    logic   [1:0]   bimState;
    logic           shouldTake;
    logic           valid;
} NLPUpdateInfo;

typedef struct packed {
    // logic   [31:0]  target;
    logic           taken;
    logic           valid;
} BPDPredInfo;

typedef struct packed {
    // logic   [31:0]  target;
    logic           taken;
    logic           valid;
} BPDUpdateInfo;

typedef struct packed {
    logic   [31:0]  inst;
    logic   [31:0]  pc;
    logic           isBr;
    logic           isDs;
    logic           isJ;
    logic   [31:0]  target;
    logic           taken;
    logic           valid;
    NLPPredInfo     nlpInfo;
    BPDPredInfo     bpdInfo;
} InstBundle;

`endif
