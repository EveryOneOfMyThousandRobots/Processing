void lin_solve(int b, float[]x, float[]x0, float a, float c)
{
  float cRecip = 1.0 / c;
  for (int k = 0; k < ITERATIONS; k++) {

    for (int j = 1; j < N - 1; j++) {
      for (int i = 1; i < N - 1; i++) {
        x[IX(i, j)] =
          (x0[IX(i, j)]
          + a*(    
          x[IX(i+1, j  )]
          +x[IX(i-1, j)]
          +x[IX(i, j+1)]
          +x[IX(i, j-1)]
          )) * cRecip;
      }
    }

    set_bnd(b, x);
  }
}
