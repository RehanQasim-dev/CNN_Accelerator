import Config::*;
`include "mac.sv"
module systolic (
    input logic clk,
    rst,
    switch,
    input logic [sys_rows-1:0] if_en,
    input logic [sys_cols-1:0] wfetch,
    input logic [sys_rows-1:0][A_BITWIDTH-1:0] if_data,
    input logic [sys_cols-1:0][A_BITWIDTH-1:0] i_wdata,
    input logic [P_BITWIDTH-1:0] bias,
    output logic [sys_cols-1:0][P_BITWIDTH-1:0] of_data
);
  /////////////////////////////////////////////////////////////////////
  logic [sys_rows-1:0][sys_cols-2:0][A_BITWIDTH-1:0] A_data;
  logic [sys_rows-1:0][sys_cols-2:0]                 A_ready;
  logic [sys_rows-1:0][sys_cols-1:0]                 W_switch;
  logic [sys_rows-2:0][sys_cols-1:0][W_BITWIDTH-1:0] W_data;
  logic [sys_rows-2:0][sys_cols-1:0]                 W_ready;
  logic [sys_rows-2:0][sys_cols-1:0][P_BITWIDTH-1:0] P_data;

  assign W_switch[0][0] = switch;
  always_ff @(posedge clk) begin
    for (int i = 0; i < sys_rows - 1; i = i + 1) begin
      W_switch[i+1][0] <= W_switch[i][0];
    end
  end
  mac mac_instance00 (
      .clk(clk),
      .rst(rst),
      .switch_in(W_switch[0][0]),
      .switch_out(W_switch[0][1]),
      .A_en(if_en[0]),
      .A_ready(A_ready[0][0]),
      .A_in(if_data[0]),
      .A_out(A_data[0][0]),
      .W_en(wfetch[0]),
      .W_ready(W_ready[0][0]),
      .W_in(i_wdata[0]),
      .W_out(W_data[0][0]),
      .P_in(bias),
      .P_out(P_data[0][0])
  );
  mac mac_instance01 (
      .clk(clk),
      .rst(rst),
      .switch_in(W_switch[0][1]),
      .switch_out(),
      .A_en(A_ready[0][0]),
      .A_ready(),
      .A_in(A_data[0][0]),
      .A_out(),
      .W_en(wfetch[1]),
      .W_ready(W_ready[0][1]),
      .W_in(i_wdata[1]),
      .W_out(W_data[0][1]),
      .P_in(bias),
      .P_out(P_data[0][1])
  );
  mac mac_instance10 (
      .clk(clk),
      .rst(rst),
      .switch_in(W_switch[1][0]),
      .switch_out(W_switch[1][1]),
      .A_en(if_en[1]),
      .A_ready(A_ready[1][0]),
      .A_in(if_data[1]),
      .A_out(A_data[1][0]),
      .W_en(W_ready[0][0] & wfetch[0]),
      .W_ready(W_ready[1][0]),
      .W_in(W_data[0][0]),
      .W_out(W_data[1][0]),
      .P_in(P_data[0][0]),
      .P_out(P_data[1][0])
  );
  mac mac_instance11 (
      .clk(clk),
      .rst(rst),
      .switch_in(W_switch[1][1]),
      .switch_out(),
      .A_en(A_ready[1][0]),
      .A_ready(),
      .A_in(A_data[1][0]),
      .A_out(),
      .W_en(W_ready[0][1] & wfetch[1]),
      .W_ready(W_ready[1][1]),
      .W_in(W_data[0][1]),
      .W_out(W_data[1][1]),
      .P_in(P_data[0][1]),
      .P_out(P_data[1][1])
  );
  mac mac_instance20 (
      .clk(clk),
      .rst(rst),
      .switch_in(W_switch[2][0]),
      .switch_out(W_switch[2][1]),
      .A_en(if_en[2]),
      .A_ready(A_ready[2][0]),
      .A_in(if_data[2]),
      .A_out(A_data[2][0]),
      .W_en(W_ready[1][0] & wfetch[0]),
      .W_ready(W_ready[2][0]),
      .W_in(W_data[1][0]),
      .W_out(W_data[2][0]),
      .P_in(P_data[1][0]),
      .P_out(P_data[2][0])
  );
  mac mac_instance21 (
      .clk(clk),
      .rst(rst),
      .switch_in(W_switch[2][1]),
      .switch_out(),
      .A_en(A_ready[2][0]),
      .A_ready(),
      .A_in(A_data[2][0]),
      .A_out(),
      .W_en(W_ready[1][1] & wfetch[1]),
      .W_ready(W_ready[2][1]),
      .W_in(W_data[1][1]),
      .W_out(W_data[2][1]),
      .P_in(P_data[1][1]),
      .P_out(P_data[2][1])
  );
  mac mac_instance30 (
      .clk(clk),
      .rst(rst),
      .switch_in(W_switch[3][0]),
      .switch_out(W_switch[3][1]),
      .A_en(if_en[3]),
      .A_ready(A_ready[3][0]),
      .A_in(if_data[3]),
      .A_out(A_data[3][0]),
      .W_en(W_ready[2][0] & wfetch[0]),
      .W_ready(),
      .W_in(W_data[2][0]),
      .W_out(),
      .P_in(P_data[2][0]),
      .P_out(of_data[0])
  );
  mac mac_instance31 (
      .clk(clk),
      .rst(rst),
      .switch_in(W_switch[3][1]),
      .switch_out(),
      .A_en(A_ready[3][0]),
      .A_ready(),
      .A_in(A_data[3][0]),
      .A_out(),
      .W_en(W_ready[2][1] & wfetch[1]),
      .W_ready(),
      .W_in(W_data[2][1]),
      .W_out(),
      .P_in(P_data[2][1]),
      .P_out(of_data[1])
  );

endmodule
