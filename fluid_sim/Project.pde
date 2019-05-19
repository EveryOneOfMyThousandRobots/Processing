void project(float[] velocX, float[] velocY, float[] p, float[] div)
{

  for (int j = 1; j < N - 1; j++) {
    for (int i = 1; i < N - 1; i++) {
      div[IX(i, j)] = -0.5f*(
        velocX[IX(i+1, j)]
        -velocX[IX(i-1, j)]
        +velocY[IX(i, j+1)]
        -velocY[IX(i, j-1)]
        )/N;
      p[IX(i, j)] = 0;
    }
  }

  setBounds(0, div); 
  setBounds(0, p);
  linearSolve(0, p, div, 1, 6);


  for (int j = 1; j < N - 1; j++) {
    for (int i = 1; i < N - 1; i++) {
      velocX[IX(i, j)] -= 0.5f * (  p[IX(i+1, j)]
        -p[IX(i-1, j)]) * N;
      velocY[IX(i, j)] -= 0.5f * (  p[IX(i, j+1)]
        -p[IX(i, j-1)]) * N;
    }
  }

  setBounds(1, velocX);
  setBounds(2, velocY);
  
}
