module if_controller (
    input  logic clk,
    rst,
    start_if,
    if_done,
    output logic if_ready,
    if_read,
    clr_if
);
  localparam READY = 1'b0;
  localparam BUSY = 1'b1;
  logic cs, ns;
  always_ff @(posedge clk) begin
    if (cs == READY) begin
      if (start_if) begin
        if_read  <= 1;
        if_ready <= 0;
        clr_if   <= 1'b1;
      end else begin
        if_read  <= 0;
        if_ready <= 1;
        clr_if   <= 1'bx;
      end
    end else if (cs == BUSY) begin
      if (!if_done) begin
        if_read  <= 1;
        if_ready <= 0;
        clr_if   <= 1'b0;
      end else begin
        if_read  <= 0;
        if_ready <= 1;
        clr_if   <= 1'bx;
      end
    end else begin
      if_read  <= '0;
      if_ready <= '0;
      clr_if   <= '0;
    end
  end

  always_comb begin
    if (cs == READY) begin
      if (start_if) begin

        ns = BUSY;
      end else begin
        ns = READY;
      end
    end else if (cs == BUSY) begin
      if (!if_done) begin
        ns = BUSY;
      end else begin
        ns = READY;
      end
    end else begin

      ns = READY;
    end
  end

  always_ff @(posedge clk) begin : blockName
    if (rst) cs <= READY;
    else cs <= ns;
  end

endmodule
