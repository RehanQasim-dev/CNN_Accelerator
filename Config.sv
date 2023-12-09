package Config;
  parameter int BIAS = 0;
  parameter A_BITWIDTH = 8;
  parameter W_BITWIDTH = 8;
  parameter P_BITWIDTH = 24;
  //systolic array configuration
  parameter int sys_rows = 2;
  parameter int sys_cols = 2;
  //
  parameter int super_A_rows = 12;
  parameter int super_B_rows = 12;
  parameter int super_w_rows = 8;
  parameter int super_w_cols = 8;
  //matrix A config
  parameter int A_rows = 3;
  parameter int A_cols = sys_rows;
  //matrix A config
  parameter int W_rows = sys_rows;
  parameter int W_cols = sys_cols;
  //Instruction Memory Size
  parameter int IBUFF_SIZE = 16;
  parameter int INSTR_SIZE = 2;
  //Buffer depths
  parameter int w_buffer_depth = 16;
  parameter int input_buffer_depth = 16;
  parameter int Accumulator_depth = 16;
  //
  parameter int counter_width = get_counter_width();
  parameter int no_of_tiles = (super_w_rows / sys_rows) * (super_w_cols / sys_cols);
  parameter int weight_dump_length = no_of_tiles * sys_rows;
  parameter int actications_dump_length = no_of_tiles * super_A_rows;
  function automatic int get_counter_width();
    if (sys_rows > sys_cols) return $clog2(sys_rows);
    else return $clog2(sys_cols);
  endfunction
endpackage : Config
