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
      .W_ready(),
      .W_in(W_data[0][0]),
      .W_out(),
      .P_in(P_data[0][0]),
      .P_out(of_data[0])
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
      .W_ready(),
      .W_in(W_data[0][1]),
      .W_out(),
      .P_in(P_data[0][1]),
      .P_out(of_data[1])
  );
