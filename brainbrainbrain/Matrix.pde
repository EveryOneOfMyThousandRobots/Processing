class Matrix {
  float[][] data;


  Matrix(int rows, int columns) {
    data = new float[rows][columns];
  }

  Matrix(float[][] array) {
    data = new float[array.length][array[0].length];
    for (int x = 0; x < array.length; x += 1) {
      for (int y = 0; y < array[x].length; y += 1) {
        data[x][y] = array[x][y];
      }
    }
  }

  Matrix(float[] array) {
    data = new float[1][array.length];
    for (int x = 0; x < array.length; x += 1) {
      data[0][x] = array[x];
    }
  }

  float[][] getArray() {

    return copyArray(data);
  }

  float[][] copyArray(float[][] ar) {
    float[][] returnValue = new float[ar.length][ar[0].length];

    for (int x = 0; x < ar.length; x += 1) {
      for (int y = 0; y < ar[x].length; y += 1) {
        returnValue[x][y] = ar[x][y];
      }
    }

    return returnValue;
  }

  void add(float m) {
    for (int x = 0; x < data.length; x += 1) {
      for (int y = 0; y < data[x].length; y += 1) {
        data[x][y] += m;
      }
    }
  }

  void sub(float m) {
    for (int x = 0; x < data.length; x += 1) {
      for (int y = 0; y < data[x].length; y += 1) {
        data[x][y] -= m;
      }
    }
  }

  void div(float m) {
    for (int x = 0; x < data.length; x += 1) {
      for (int y = 0; y < data[x].length; y += 1) {
        data[x][y] /= m;
      }
    }
  }



  void mult(float m) {
    for (int x = 0; x < data.length; x += 1) {
      for (int y = 0; y < data[x].length; y += 1) {
        data[x][y] *= m;
      }
    }
  }
}