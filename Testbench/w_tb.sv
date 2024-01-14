`include "w_controller.sv"
module w_tb;

  // Inputs
  logic clk, rst, start, if_ready, w_done;

  // Outputs
  logic start_if, w_read, switch, clr_w, ready;

  // Instantiate the DUT
  w_controller dut (
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

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Reset and test sequence
  initial begin
    rst = 1'b1;
    start = 0;
    if_ready = 0;
    w_done = 0;
    @(posedge clk);
    rst   = 0;
    start = 1;
    @(posedge clk);
    start = 0;
    repeat (6) @(posedge clk);
    w_done = 1;
    repeat (6) @(posedge clk);
    if_ready = 1;
    repeat (6) @(posedge clk);
    $finish;
  end

  // Display simulation time
  always @(posedge clk) begin
    $display("Time = %0t, start_if = %b, w_read = %b, switch = %b, clr_w = %b, ready = %b cs=%b",
             $time, start_if, w_read, switch, clr_w, ready, dut.ns);
  end
  initial begin
    $dumpfile("tb_controller_dump.vcd");
    $dumpvars(1, dut);
  end
endmodule
