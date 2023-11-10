import Config::*;
module top (
    input clk,
    input rst,
    start,
    output logic [sys_cols-1:0][P_BITWIDTH-1:0] result,
    output logic ready
);
  logic w_read, if_read, w_done, if_done;
  logic clr;
  controller controller_instance (
      .clk(clk),
      .rst(rst),
      .start(start),
      .w_done(w_done),
      .if_done(if_done),
      .w_read(w_read),
      .if_read(if_read),
      .clr(clr),
      .ready(ready)
  );

  datapath datapath_instance (
      .clk(clk),
      .rst(rst),
      .w_buffer_read(w_read),
      .if_buffer_read(if_read),
      .clr(clr),
      .of_data(result),
      .w_done(w_done),
      .if_done(if_done)
  );

endmodule : top