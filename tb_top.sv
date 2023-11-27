`include "top.sv"
import Config::*;
module tb_top;
  logic clk, rst, start, ready;
  logic [sys_cols-1:0][P_BITWIDTH-1:0] result;
  top dut (
      .clk(clk),
      .rst(rst),
      .start(start),
      .result(result),
      .ready(ready)
  );
  logic [sys_rows-2:0][sys_cols-1:0][W_BITWIDTH-1:0] W_data;
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
    rst   <= 1;
    start <= 0;
    @(posedge clk);
    rst   <= 0;
    start <= 1;
    @(posedge clk);
    // start <= 0;
    repeat (50) @(posedge clk);
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
