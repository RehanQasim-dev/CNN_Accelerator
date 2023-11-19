module if_controller (
    input  logic clk,
    rst,
    start_if,
    if_done,
    output logic if_ready,
    if_read,
    clr_if
);
  localparam logic READY = 0;
  localparam BUSY = 1;
  logic cs, ns;
  always @(posedge clk) begin
    if (cs == READY) begin
      if (start_if) begin

        if_read = 1;
        if_ready = 0;
        clr_if = 1'b1;
        ns = BUSY;
      end else begin
        if_read = 0;
        if_ready = 1;
        clr_if = 1'bx;
        ns = READY;
      end
    end
    if (cs == BUSY) begin
      if (~if_done) begin
        if_read = 1;
        if_ready = 0;
        clr_if = 1'b0;
        ns = BUSY;
      end else begin
        if_read = 0;
        if_ready = 1;
        clr_if = 1'bx;
        ns = BUSY;
      end
    end
  end

  always_ff @(posedge clk) begin : blockName
    if (rst) cs <= 0;
    else cs <= ns;
  end

endmodule
