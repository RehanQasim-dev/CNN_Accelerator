package Config;
  parameter A_BITWIDTH = 8;
  parameter W_BITWIDTH = 8;
  parameter P_BITWIDTH = 24;
  //matrix A config
  parameter int A_rows = 3;
  parameter int A_cols = 5;
  //matrix A config
  parameter int W_rows = 5;
  parameter int W_cols = 3;
  //systolic array configuration
  parameter int sys_rows = 5;
  parameter int sys_cols = 3;
  //Buffer depths
  parameter int w_buffer_depth = 16;
  parameter int input_buffer_depth = 16;
  parameter int counter_width = get_counter_width();
  function automatic int get_counter_width();
    if (sys_rows > sys_cols) return $clog2(sys_rows);
    else return $clog2(sys_cols);
  endfunction
endpackage : Config