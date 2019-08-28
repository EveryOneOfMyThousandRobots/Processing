void set_bnd(int b, float[] x)
{


  for (int i = 1; i < N - 1; i++) {
    x[IX(i, 0)] = b == 2 ? -x[IX(i, 1)] : x[IX(i, 1)];
    x[IX(i, N-1)] = b == 2 ? -x[IX(i, N-2)] : x[IX(i, N-2)];
  }


  for (int j = 1; j < N - 1; j++) {
    x[IX(0, j)] = b == 1 ? -x[IX(1, j)] : x[IX(1, j)];
    x[IX(N-1, j)] = b == 1 ? -x[IX(N-2, j)] : x[IX(N-2, j)];
  }


  x[IX(0, 0)]       = 0.33f * (x[IX(1, 0)] + x[IX(0, 1)]);
  x[IX(0, N-1)]     = 0.33f * (x[IX(1, N-1)] + x[IX(0, N-2)]);
  x[IX(N-1, 0)]     = 0.33f * (x[IX(N-2, 0)] + x[IX(N-1, 1)]);
  x[IX(N-1, N-1)]   = 0.33f * (x[IX(N-2, N-1)]+ x[IX(N-1, N-2)]);
}
