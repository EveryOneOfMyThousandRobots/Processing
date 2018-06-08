public static class Matrix {
  final int rand_id;// = floor(random(1, 1000000000));
  final int rows, cols;
  private float[][] data;
  static PApplet applet;
  private Matrix(int rows, int cols) {
    rand_id = floor(applet.random(1, 10000000));
    this.rows = rows;
    this.cols = cols;
    data = new float[rows][cols];

    for (int r = 0; r < rows; r += 1) {
      for (int c = 0; c < cols; c += 1) {
        data[r][c] = 0;
      }
    }
  }

  static Matrix getMatrix(int rows, int cols) {
    Matrix m = new Matrix(rows, cols);

    return m;
  }

  void display() {
    print("\nMatrix " + rows + "x" + cols);
    for (int r = 0; r < rows; r += 1) {
      if (r == 0) {
        print("\n\t");
        for (int c = 0; c < cols; c += 1) {
          print("\t[" + c + "]");
        }
      }
      print("\n\t[" + r + "]");

      for (int c = 0; c < cols; c += 1) {
        print("\t" + data[r][c]);
      }
    }
  }

  static void init(PApplet applet_) {
    applet = applet_;
  }

  Matrix transpose() {
    Matrix result = new Matrix(this.cols, this.rows);
    for (int r = 0; r < rows; r += 1) {
      for (int c = 0; c < cols; c += 1) {
        result.data[c][r] = data[r][c];
      }
    }
    return result;
  }

  String toString() {
    return this.getClass() + " (" + rows + "x" + cols + ")";
  }

  int hashCode() {
    return rows * cols * 17 + rand_id;
  }

  boolean set(int r, int c, float v) {
    boolean result = false;

    if (r >= 0 && r < rows && c >= 0 && c < cols) {
      data[r][c] = v;
    }


    return result;
  }

  float get(int r, int c) {
    if (r >= 0 && r < rows && c >= 0 && c < cols) {
      return data[r][c];
    } else {
      return 0;
    }
  }


  //elemental
  void add(Matrix o) {
    if (o.cols == cols && o.rows == rows) {
      for (int r = 0; r < rows; r += 1) {
        for (int c = 0; c < cols; c += 1) {
          data[r][c] += o.data[r][c];
        }
      }
    } else {
      println("add: invalid array. a=" + this.rows + "x" + this.cols + " b=" + o.rows + "x" + o.cols);
    }
  }

  void sub(Matrix o) {
    if (o.cols == cols && o.rows == rows) {
      for (int r = 0; r < rows; r += 1) {
        for (int c = 0; c < cols; c += 1) {
          data[r][c] -= o.data[r][c];
        }
      }
    } else {
      println("\nsub: invalid array. a=" + this.rows + "x" + this.cols + " b=" + o.rows + "x" + o.cols);
    }
  }



  void mult(Matrix o) {
    if (o.cols == cols && o.rows == rows) {
      for (int r = 0; r < rows; r += 1) {
        for (int c = 0; c < cols; c += 1) {
          data[r][c] *= o.data[r][c];
        }
      }
    } else {
      println("mult: invalid array.");
    }
  }

  float[] toArray() {
    float[] arr = new float[rows * cols];
    for (int r = 0; r < rows; r += 1) {
      for (int c = 0; c < cols; c += 1) {
        arr[r + c * cols] = data[r][c];
      }
    }

    return arr;
  }





  void clear() {
    for (int r = 0; r < rows; r += 1) {
      for (int c = 0; c < cols; c += 1) {
        data[r][c] = 0;
      }
    }
  }

  Matrix copy() {
    Matrix nm = new Matrix(this.rows, this.cols);
    for (int r = 0; r < rows; r += 1) {
      for (int c = 0; c < cols; c += 1) {
        nm.data[r][c] = this.data[r][c];
      }
    }
    return nm;
  }

  void randomise() {
    for (int r = 0; r < rows; r += 1) {
      for (int c = 0; c < cols; c += 1) {
        data[r][c] = floor(applet.random(-10, 10));
      }
    }
  }

  void randomise(float min, float max) {
    for (int r = 0; r < rows; r += 1) {
      for (int c = 0; c < cols; c += 1) {
        data[r][c] = applet.random(min, max);
      }
    }
  }

  //scalar functions



  void mult(float n) {
    for (int r = 0; r < rows; r += 1) {
      for (int c = 0; c < cols; c += 1) {
        data[r][c] *= n;
      }
    }
  }

  void add(float n) {
    for (int r = 0; r < rows; r += 1) {
      for (int c = 0; c < cols; c += 1) {
        data[r][c] += n;
      }
    }
  }

  void sub(float n) {
    add(-n);
  }

  void setSigmoid() {
    for (int r = 0; r < rows; r += 1) {
      for (int c = 0; c < cols; c += 1) {
        data[r][c] = Matrix.sigmoid(data[r][c]);
      }
    }
  }

  void power(float e) {
    for (int r = 0; r < rows; r += 1) {
      for (int c = 0; c < cols; c += 1) {
        data[r][c] = pow(data[r][c], e);
      }
    }
  }



  //"static"
  static Matrix add(Matrix a, Matrix b) {
    Matrix m = a.copy();
    m.add(b);
    return m;
  }

  static Matrix add(Matrix a, float n) {
    Matrix m = a.copy();
    m.add(n);
    return m;
  }

  static Matrix sub(Matrix a, Matrix b) {
    Matrix m = a.copy();
    m.sub(b);
    return m;
  }


  static Matrix mult(Matrix a, Matrix b) {
    Matrix m = a.copy();
    m.mult(b);
    return m;
  }

  static Matrix mult(Matrix a, float n) {
    Matrix m = a.copy();
    m.mult(n);
    return m;
  }

  static Matrix matrixProduct (Matrix a, Matrix b) {
    Matrix nm = null;
    if (a.cols == b.rows) {
      nm = new Matrix(a.rows, b.cols);

      for (int i = 0; i < nm.rows; i += 1) {
        for (int j = 0; j < nm.cols; j += 1) {
          for (int k = 0; k < a.cols; k += 1) {
            //println("i:" + i + ", j:" + j + ", k:" + k);
            nm.data[i][j] += a.data[i][k] * b.data[k][j];
          }
        }
      }
    }

    return nm;
  }

  static Matrix fromArray(float[] arr) {
    Matrix nm = new Matrix(arr.length, 1);

    for (int i = 0; i < arr.length; i += 1) {
      nm.set(i, 0, arr[i]);
    }

    return nm;
  }



  static float doubleIt(float n) {
    return n * 2;
  }

  static float sigmoid(float x) {
    return 1 / (1 + exp(-x));
  }
}
