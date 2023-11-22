`include "w_controller.sv"
`include "if_controller.sv"
module controller (
    input clk,
    input rst,
    input start,
    w_done,
    if_done,
    output logic w_read,
    if_read,
    clr_w,
    clr_if,
    switch,
    ready
);
  logic start_if, if_ready;
  w_controller w_controller_instance (
      .clk(clk),
      .rst(rst),
      .start(start),
      .if_ready(if_ready),
      .w_done(w_done),
      .start_if(start_if),
      .w_read(w_read),
      .switch(switch),
      .clr_w(clr_w),
      .ready(ready)
  );
  if_controller if_controller_instance (
      .clk(clk),
      .rst(rst),
      .start_if(start_if),
      .if_done(if_done),
      .if_ready(if_ready),
      .if_read(if_read),
      .clr_if(clr_if)
  );

endmodule : controller
