`include "datapath.sv"
`include "controller.sv"

import Config::*;
module top (
    input clk,
    input rst,
    start,
    output logic [sys_cols-1:0][P_BITWIDTH-1:0] result,
    output logic ready
);
  logic w_read, if_read, w_done, if_done;
  logic clr_w, clr_if, switch, rd_nxt_inst, first, last;
  controller controller_instance (
      .clk(clk),
      .rst(rst),
      .start(start),
      .w_done(w_done),
      .if_done(if_done),
      .rd_nxt_inst(rd_nxt_inst),
      .w_read(w_read),
      .if_read(if_read),
      .clr_w(clr_w),
      .clr_if(clr_if),
      .switch(switch),
      .ready(ready),
      .first(first),
      .last(last)
  );

  datapath datapath_instance (
      .clk(clk),
      .rst(rst),
      .w_buffer_read(w_read),
      .if_buffer_read(if_read),
      .clr_w(clr_w),
      .clr_if(clr_if),
      .switch(switch),
      .first(first),
      .last(last),
      .of_data(result),
      .w_done(w_done),
      .if_done(if_done),
      .rd_nxt_inst(rd_nxt_inst)

  );


endmodule : top
