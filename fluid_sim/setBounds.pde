void setBounds(int b, float[] x)
{

  //for (int k = 1; k < N - 1; k++) {
  for (int i = 1; i < N - 1; i++) {
    x[IX(i, 0  )] = b == 2 ? -x[IX(i, 1  )] : x[IX(i, 1  )];
    x[IX(i, N-1)] = b == 2 ? -x[IX(i, N-2)] : x[IX(i, N-2)];
  }
  //}
  //for(int k = 1; k < N - 1; k++) {
  for (int j = 1; j < N - 1; j++) {
    x[IX(0, j)] = b == 1 ? -x[IX(1, j)] : x[IX(1, j)];
    x[IX(N-1, j)] = b == 1 ? -x[IX(N-2, j)] : x[IX(N-2, j)];
  }
  //}
  
  x[IX(0, 0)]       = SET_BOUNDS_FACTOR * (x[IX(1, 0)]    + x[IX(0, 1)]);
  x[IX(0, N-1)]     = SET_BOUNDS_FACTOR * (x[IX(1, N-1)]  + x[IX(0, N-2)]);
  x[IX(N-1, 0)]     = SET_BOUNDS_FACTOR * (x[IX(N-2, 0)]  + x[IX(N-1, 1)]);
  x[IX(N-1, N-1)]   = SET_BOUNDS_FACTOR * (x[IX(N-2, N-1)]+ x[IX(N-1, N-2)]);
    
}
