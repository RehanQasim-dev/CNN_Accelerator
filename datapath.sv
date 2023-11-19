import Config::*;
module datapath (
    input logic clk,
    rst,
    w_buffer_read,
    if_buffer_read,
    clr,
    output logic [sys_cols-1:0][P_BITWIDTH-1:0] of_data,
    output logic w_done,
    if_done
);

  logic [sys_rows-1:0] if_en;
  logic [sys_rows-1:0][A_BITWIDTH-1:0] if_data;
  logic [sys_cols-1:0][W_BITWIDTH-1:0] i_wdata;
  logic [sys_cols-1:0] wfetch;
  logic [counter_width-1:0] count;
  assign w_done  = count == sys_rows - 1;
  assign if_done = count == A_rows - 1;
  always_ff @(posedge clk) begin
    if (clr) count <= 0;
    else count <= count + 1;
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

  sys sys_instance (
      .clk(clk),
      .rst(rst),
      .if_en(if_en),
      .wfetch(wfetch),
      .if_data(if_data),
      .i_wdata(i_wdata),
      .bias(BIAS),
      .of_data(of_data)
  );
endmodule
