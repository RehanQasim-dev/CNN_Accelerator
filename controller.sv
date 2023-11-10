module controller (
    input clk,
    input rst,
    input start,
    w_done,
    if_done,
    output logic w_read,
    if_read,
    clr,
    ready
);
  // logic counter[$clog2(sys_h)-1:0];
  localparam READY = 2'b00;
  localparam W_FETCH = 2'b01;
  localparam BUSY = 2'b10;
  logic [1:0] cs, ns;

  always @(posedge clk) begin
    if (cs == READY) begin
      if (~start) begin
        w_read = 0;
        if_read = 0;
        ready = 1;
        clr = 0;
        ns = READY;
      end else begin
        w_read = 1;
        if_read = 0;
        ready = 0;
        clr = 1;
        ns = W_FETCH;
      end
    end else if (cs == W_FETCH) begin
      if (~w_done) begin
        w_read = 1;
        if_read = 0;
        ready = 0;
        clr = 0;
        ns = W_FETCH;
      end else begin
        w_read = 0;
        if_read = 1;
        ready = 0;
        clr = 1;
        ns = BUSY;

      end
    end
    if (cs == BUSY) begin
      if (~if_done) begin
        w_read = 0;
        if_read = 1;
        ready = 0;
        ns = BUSY;
        clr = 0;
      end else begin
        w_read = 0;
        if_read = 0;
        ready = 0;
        ns = READY;
        clr = 1;
      end
    end
  end

  always_ff @(posedge clk) begin : blockName
    if (rst) cs <= 0;
    else cs <= ns;
  end

endmodule : controller
