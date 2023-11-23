module tb_if;

  // Inputs
  logic clk, rst, start_if, if_done;

  // Outputs
  logic if_ready, if_read, clr_if;

  // Instantiate the DUT
  if_controller dut (
      .clk(clk),
      .rst(rst),
      .start_if(start_if),
      .if_done(if_done),
      .if_ready(if_ready),
      .if_read(if_read),
      .clr_if(clr_if)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Reset and test sequence
  initial begin
    rst = 1'b1;
    start_if = 0;
    if_done = 0;

    @(posedge clk);
    rst = 1'b0;  // Release reset after 10 time units
    start_if = 1'b1;
    // Test sequence

    repeat (7) @(posedge clk);
    if_done = 1'b1;  // Clearing if_done
    repeat (7) @(posedge clk);
    $finish;  // End simulation
  end

  // Display simulation time
  always @(posedge clk) begin
    $display("Time = %0t, if_ready = %b, if_read = %b, clr_if = %b", $time, if_ready, if_read,
             clr_if);
  end
  initial begin
    $dumpfile("tb_controller_dump.vcd");
    $dumpvars(1, dut);
  end
endmodule

