module w_controller (
    input  logic clk,
    rst,
    start,
    if_ready,
    w_done,
    output logic start_if,
    w_read,
    switch,
    clr_w,
    ready
);
  // logic start_if;
  // always_ff @(posedge clk) begin : blockName
  //   if (rst) start_late_if <= 0;
  //   else start_late_if <= start_if;
  // end
  localparam READY = 2'b00;
  localparam FETCH = 2'b01;
  localparam WAIT = 2'b10;
  logic [1:0] ns, cs;
  always_comb begin
    if (cs == READY) begin
      if (start) begin
        start_if = 0;
        w_read = 1;
        switch = 0;
        ready = 0;
        clr_w = 1'b1;
        ns = FETCH;
        $display("start=1");
      end else begin
        start_if = 0;
        w_read = 0;
        switch = 0;
        ready = 1;
        clr_w = 1'bx;
        ns = READY;
      end
    end else if (cs == FETCH) begin
      if (~w_done) begin
        start_if = 0;
        w_read = 1;
        switch = 0;
        ready = 0;
        clr_w = 1'b0;
        ns = FETCH;
      end else if (w_done & if_ready) begin
        start_if = 1;
        w_read = 0;
        switch = 1;
        ready = 1;
        clr_w = 1'bx;
        ns = READY;
      end else begin
        start_if = 0;
        w_read = 0;
        switch = 0;
        ready = 0;
        clr_w = 1'bx;
        ns = WAIT;
      end
    end else if (cs == WAIT) begin
      if (~if_ready) begin
        start_if = 0;
        w_read = 0;
        switch = 0;
        ready = 0;
        clr_w = 1'bx;
        ns = WAIT;
      end else begin
        start_if = 1;
        w_read = 0;
        switch = 1;
        ready = 1;
        clr_w = 1'bx;
        ns = READY;
      end
    end else begin
      start_if = 'x;
      w_read = 'x;
      switch = 'x;
      ready = 'x;
      clr_w = 'x;
      ns = READY;
    end

  end
  //switch and if_start are same
  always_ff @(posedge clk) begin
    if (rst) cs <= READY;
    else cs <= ns;
  end


endmodule
