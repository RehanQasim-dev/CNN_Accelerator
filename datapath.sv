`include "systolic.sv"
`include "input_buffer.sv"
`include "weight_buffer.sv"
import Config::*;
module datapath (
    input logic clk,
    rst,
    w_buffer_read,
    if_buffer_read,
    clr_w,
    clr_if,
    switch,
    output logic [sys_cols-1:0][P_BITWIDTH-1:0] of_data,
    output logic w_done,
    if_done
);

  logic [sys_rows-1:0] if_en;
  logic [sys_rows-1:0][A_BITWIDTH-1:0] if_data;
  logic [sys_cols-1:0][W_BITWIDTH-1:0] i_wdata;
  logic [sys_cols-1:0] wfetch;
  logic [$clog2(sys_rows)-1:0] count_w;
  logic [$clog2(A_rows)-1:0] count_if;
  assign w_done  = count_w == sys_rows - 1;
  assign if_done = count_if == A_rows - 1;
  always_ff @(posedge clk) begin
    if (clr_w) count_w <= 0;
    else count_w <= count_w + 1;
  end
  always_ff @(posedge clk) begin
    if (clr_if) count_if <= 0;
    else count_if <= count_if + 1;
  end
  weight_buffer weight_buffer_instance (
      .rst(rst),
      .clk(clk),
      .read(w_buffer_read),
      .o_valid(wfetch),
      .o_data(i_wdata)
  );
  input_buffer input_buffer_instance (
      .rst(rst),
      .clk(clk),
      .read(if_buffer_read),
      .o_valid(if_en),
      .o_data(if_data)
  );

  systolic sys_instance (
      .clk(clk),
      .rst(rst),
      .switch(switch),
      .if_en(if_en),
      .wfetch(wfetch),
      .if_data(if_data),
      .i_wdata(i_wdata),
      .bias(3'b000),
      .of_data(of_data)
  );
endmodule
