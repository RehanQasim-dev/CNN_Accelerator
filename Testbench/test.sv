import Config::*;
module test;

  // Define parameters for matrix size
  parameter ROWS_A = 3;
  parameter COLS_A = 3;
  parameter COLS_B = 3;

  // Function to multiply matrices
  function automatic void matrix_multiply(int unsigned A[ROWS_A][COLS_A],
                                          int unsigned B[COLS_A][COLS_B],
                                          int unsigned C[ROWS_A][COLS_B]);
    int unsigned i, j, k;
    for (i = 0; i < ROWS_A; i++) begin
      for (j = 0; j < COLS_B; j++) begin
        C[i][j] = 0;
        for (k = 0; k < COLS_A; k++) begin
          C[i][j] += A[i][k] * B[k][j];
        end
      end
    end
  endfunction

  initial begin
    repeat (100) begin
      $display("%p", generate_activations());
      $display("%p", generate_weights());
    end
  end
endmodule
