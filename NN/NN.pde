class Network {
  int numInput;
  int numHidden;
  int numOutput;
  Network(int numInput, int numHidden, int numOutput) {
    this.numInput = numInput;
    this.numHidden = numHidden;
    this.numOutput = numOutput;
  }
}

class Matrix {
  int numRows, numCols;
  float[][] matrix;
  Matrix(int numRows, int numCols) {
    this.numRows = numRows;
    this.numCols = numCols;
    this.matrix = new float[numRows][numCols];

    for (int r = 0; r < matrix.length; r += 1) {
      for (int c = 0; c < matrix[r].length; c += 1) {
        matrix[r][c] = 0;
      }
    }
  }
  
  float cross() {
  }

  void randomise() {
    for (int r = 0; r < matrix.length; r += 1) {
      for (int c = 0; c < matrix[r].length; c += 1) {
        matrix[r][c] = floor(random(10));
      }
    }
  }

  void mult(float n) {
    for (int r = 0; r < matrix.length; r += 1) {
      for (int c = 0; c < matrix[r].length; c += 1) {
        matrix[r][c] *= n;
      }
    }
  }
  void mult(Matrix m) {
    if (matrix.length != m.matrix.length || matrix[0].length != m.matrix[0].length) {
      return;
    }
    for (int r = 0; r < matrix.length; r += 1) {

      for (int c = 0; c < matrix[r].length; c += 1) {
        matrix[r][c] *= m.matrix[r][c];
      }
    }
  }

  void add(Matrix m) {
    if (matrix.length != m.matrix.length || matrix[0].length != m.matrix[0].length) {
      return;
    }
    for (int r = 0; r < matrix.length; r += 1) {
      for (int c = 0; c < matrix[r].length; c += 1) {
        matrix[r][c] += m.matrix[r][c];
      }
    }
  }

  void add(float n) {
    for (int r = 0; r < matrix.length; r += 1) {
      for (int c = 0; c < matrix[r].length; c += 1) {
        matrix[r][c] += n;
      }
    }
  }


  String toString() {
    String out = "";
    for (int r = 0; r < matrix.length; r += 1) {
      out += "\n[" + r + "]";
      for (int c = 0; c < matrix[r].length; c += 1) {
        out += "\t" + matrix[r][c];
      }
    }
    return out;
  }
}

Network brain;
void setup() {
  size(200, 200);

  brain = new Network(2, 4, 2);
  Matrix m = new Matrix(3, 2);
  Matrix m1 = new Matrix(3, 2);

  m.randomise();
  m1.randomise();
  println("m = " + m);
  //m.add(1);
  //m.mult(0.5);
  println("m1 = " + m1);
  m.mult(m1);
  println("m = " + m);
}

void draw() {
}