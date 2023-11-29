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
  localparam int IDLE = 0;
  localparam int FETCH = 1;
  localparam int FetchAndConv = 2;
  localparam int CONV = 3;
  localparam int W_WAIT = 4;
  logic [2:0] cs, ns;
  always_comb begin
    ready   = 0;
    clr_w   = 0;
    clr_if  = 0;
    switch  = 0;
    w_read  = 0;
    if_read = 0;
    case (cs)
      IDLE:
      if (~start) begin
        ready = 1;
        ns = IDLE;
      end else begin
        clr_w = 1;
        ns = FETCH;
      end
      FETCH:
      if (~w_done) begin
        w_read = 1;
        ns = FETCH;
      end else if (w_done & start) begin
        switch = 1;
        // w_read = 1;
        // if_read = 1;
        clr_if = 1;
        clr_w = 1;
        ns = FetchAndConv;
      end else begin
        switch = 1;
        clr_if = 1;
        // if_read = 1;
        ns = CONV;
      end
      FetchAndConv:
      if (start & if_done & w_done) begin
        switch = 1;
        // w_read = 1;
        // if_read = 1;
        clr_if = 1;
        clr_w = 1;
        ns = FetchAndConv;
      end else if (~if_done & ~w_done) begin
        w_read = 1;
        if_read = 1;
        ns = FetchAndConv;
      end else if (if_done & ~w_done) begin
        w_read = 1;
        ns = FETCH;
      end else begin
        if_read = 1;
        ns = W_WAIT;
      end
      CONV:
      if (~start & ~if_done) begin
        if_read = 1;

      end else if (if_done & start) begin
        clr_w = 1;
        // w_read = 1;
        ns = FETCH;
      end else if (~if_done & start) begin
        clr_w = 1;
        // w_read = 1;
        ns = FetchAndConv;
      end else begin
        ready = 1;
        ns = IDLE;
      end
      W_WAIT:
      if (~if_done) begin
        if_read = 1;
      end else if (start & if_done) begin
        switch = 1;
        clr_if = 1;
        clr_w = 1;
        ns = FetchAndConv;
      end else begin
        clr_w = 1;
        clr_if = 1;
        clr_w = 1;
        ns = CONV;
      end
    endcase
  end
  always_ff @(posedge clk) begin
    if (rst) cs <= 0;
    else cs <= ns;
  end
endmodule : controller
