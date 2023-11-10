mac mac_instance00 (
      .clk(clk),
      .rst(rst),
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
      .A_en(A_ready[0][0]),
      .A_ready(A_ready[0][1]),
      .A_in(A_data[0][0]),
      .A_out(A_data[0][1]),
      .W_en(wfetch[1]),
      .W_ready(W_ready[0][1]),
      .W_in(i_wdata[1]),
      .W_out(W_data[0][1]),
      .P_in(bias),
      .P_out(P_data[0][1])
  );
mac mac_instance02 (
      .clk(clk),
      .rst(rst),
      .A_en(A_ready[0][1]),
      .A_ready(),
      .A_in(A_data[0][1]),
      .A_out(),
      .W_en(wfetch[2]),
      .W_ready(W_ready[0][2]),
      .W_in(i_wdata[2]),
      .W_out(W_data[0][2]),
      .P_in(bias),
      .P_out(P_data[0][2])
  );
mac mac_instance10 (
      .clk(clk),
      .rst(rst),
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
      .A_en(A_ready[1][0]),
      .A_ready(A_ready[1][1]),
      .A_in(A_data[1][0]),
      .A_out(A_data[1][1]),
      .W_en(W_ready[0][1] & wfetch[1]),
      .W_ready(W_ready[1][1]),
      .W_in(W_data[0][1]),
      .W_out(W_data[1][1]),
      .P_in(P_data[0][1]),
      .P_out(P_data[1][1])
  );
mac mac_instance12 (
      .clk(clk),
      .rst(rst),
      .A_en(A_ready[1][1]),
      .A_ready(),
      .A_in(A_data[1][1]),
      .A_out(),
      .W_en(W_ready[0][2] & wfetch[2]),
      .W_ready(W_ready[1][2]),
      .W_in(W_data[0][2]),
      .W_out(W_data[1][2]),
      .P_in(P_data[0][2]),
      .P_out(P_data[1][2])
  );
mac mac_instance20 (
      .clk(clk),
      .rst(rst),
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
      .A_en(A_ready[2][0]),
      .A_ready(A_ready[2][1]),
      .A_in(A_data[2][0]),
      .A_out(A_data[2][1]),
      .W_en(W_ready[1][1] & wfetch[1]),
      .W_ready(W_ready[2][1]),
      .W_in(W_data[1][1]),
      .W_out(W_data[2][1]),
      .P_in(P_data[1][1]),
      .P_out(P_data[2][1])
  );
mac mac_instance22 (
      .clk(clk),
      .rst(rst),
      .A_en(A_ready[2][1]),
      .A_ready(),
      .A_in(A_data[2][1]),
      .A_out(),
      .W_en(W_ready[1][2] & wfetch[2]),
      .W_ready(W_ready[2][2]),
      .W_in(W_data[1][2]),
      .W_out(W_data[2][2]),
      .P_in(P_data[1][2]),
      .P_out(P_data[2][2])
  );
mac mac_instance30 (
      .clk(clk),
      .rst(rst),
      .A_en(if_en[3]),
      .A_ready(A_ready[3][0]),
      .A_in(if_data[3]),
      .A_out(A_data[3][0]),
      .W_en(W_ready[2][0] & wfetch[0]),
      .W_ready(W_ready[3][0]),
      .W_in(W_data[2][0]),
      .W_out(W_data[3][0]),
      .P_in(P_data[2][0]),
      .P_out(P_data[3][0])
  );
mac mac_instance31 (
      .clk(clk),
      .rst(rst),
      .A_en(A_ready[3][0]),
      .A_ready(A_ready[3][1]),
      .A_in(A_data[3][0]),
      .A_out(A_data[3][1]),
      .W_en(W_ready[2][1] & wfetch[1]),
      .W_ready(W_ready[3][1]),
      .W_in(W_data[2][1]),
      .W_out(W_data[3][1]),
      .P_in(P_data[2][1]),
      .P_out(P_data[3][1])
  );
mac mac_instance32 (
      .clk(clk),
      .rst(rst),
      .A_en(A_ready[3][1]),
      .A_ready(),
      .A_in(A_data[3][1]),
      .A_out(),
      .W_en(W_ready[2][2] & wfetch[2]),
      .W_ready(W_ready[3][2]),
      .W_in(W_data[2][2]),
      .W_out(W_data[3][2]),
      .P_in(P_data[2][2]),
      .P_out(P_data[3][2])
  );
mac mac_instance40 (
      .clk(clk),
      .rst(rst),
      .A_en(if_en[4]),
      .A_ready(A_ready[4][0]),
      .A_in(if_data[4]),
      .A_out(A_data[4][0]),
      .W_en(W_ready[3][0] & wfetch[0]),
      .W_ready(),
      .W_in(W_data[3][0]),
      .W_out(),
      .P_in(P_data[3][0]),
      .P_out(of_data[0])
  );
mac mac_instance41 (
      .clk(clk),
      .rst(rst),
      .A_en(A_ready[4][0]),
      .A_ready(A_ready[4][1]),
      .A_in(A_data[4][0]),
      .A_out(A_data[4][1]),
      .W_en(W_ready[3][1] & wfetch[1]),
      .W_ready(),
      .W_in(W_data[3][1]),
      .W_out(),
      .P_in(P_data[3][1]),
      .P_out(of_data[1])
  );
mac mac_instance42 (
      .clk(clk),
      .rst(rst),
      .A_en(A_ready[4][1]),
      .A_ready(),
      .A_in(A_data[4][1]),
      .A_out(),
      .W_en(W_ready[3][2] & wfetch[2]),
      .W_ready(),
      .W_in(W_data[3][2]),
      .W_out(),
      .P_in(P_data[3][2]),
      .P_out(of_data[2])
  );
