int getIndex(int x, int y) {
  x = constrain(x, 0, N-1);
  y = constrain(y, 0, N-1);
  int rv = x + y * N;

  return rv;
}

int IX(int x, int y) {
  return getIndex(x, y);
}
void diffuse (int b, float[] x, float[] x0, float diff, float dt)
{
  float a = dt * diff * (N - 2) * (N - 2);
  linearSolve(b, x, x0, a, 1 + 6 * a);
}

void linearSolve(int b, float[] x, float[] x0, float a, float c) {
  float cRecip = 1.0 / c;
  for (int k = 0; k < iterations; k++) {
    for (int j = 1; j < N - 1; j++) {
      for (int i = 1; i < N - 1; i++) {
        x[IX(i, j)] =
          (x0[IX(i, j)]
          + a*(    
           x[IX(i+1, j)]
          +x[IX(i-1, j)]
          +x[IX(i, j+1)]
          +x[IX(i, j-1)]

          )) * cRecip;
      }
    }

    setBounds(b, x);
  }
}
