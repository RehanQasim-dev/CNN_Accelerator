`include "top.sv"

module tb_top;
  logic clk, rst, start, ready;
  logic [2:0][23:0] result;
  top dut (
      .clk(clk),
      .rst(rst),
      .start(start),
      .result(result),
      .ready(ready)
  );
  logic [4:0][2:0][7:0] W_data;
  assign W_data = dut.datapath_instance.sys_instance.W_data;
  //clock generation
  localparam CLK_PERIOD = 10;
  initial begin
    clk = 0;
    forever begin
      #(CLK_PERIOD / 2);
      clk = ~clk;
    end
  end
  //Testbench

  initial begin
    rst   = 1;
    start = 0;
    @(posedge clk);
    @(posedge clk);
    rst   = 0;
    start = 1;
    @(posedge clk);
    repeat (30) @(posedge clk);
    $finish;
  end
  int i;
  //Monitor values at posedge
  always @(posedge clk) begin
    for (i = 0; i < 5; i = i + 1) $display(" %d %d %d", W_data[i][0], W_data[i][1], W_data[i][2]);
    $display("----------------------------------------------------------");
  end

  //Value change dump

  initial begin
    $dumpfile("tb_top_dump.vcd");
    $dumpvars(1, dut);
  end
endmodule
