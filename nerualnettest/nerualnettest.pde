float[][] input = {{0, 1, 1}, {0, 0, 1}, {1, 1, 1}, {1, 0, 1}};
float[][] ouput = {{1}, {0}, {0}, {1}};

float[][] hidden = {{0}, {0}, {0}, {0}};

float[][] syn_in = new float[3][4];
float[][] syn_out = new float[4][1];

void setup() {
  randomSeed(1);
  for (int n = 0; n < 2; n += 1) {
    float[][] a;
    if (n == 0) {
      a = syn_in;
    } else {
      a = syn_out;
    }

    for (int x = 0; x < a.length; x += 1) {
      for (int y = 0; y < a[x].length; y += 1) {
        a[x][y] = random(1);
      }
    }
  }

  printArray(syn_in);
  printArray(syn_out);

  for (int x = 0; x < hidden.length; x += 1) {
    for (int y = 0; y < hidden[x].length; y += 1) {
      for (int xx = 0; xx < input.length; x += 1) {
        for (int yy = 0; yy < input[xx].length; y += 1) {
          hidden[x][y] += input[xx][yy] * syn_in[xx][yy];
          
        }
      }
    }
  }
}

void printArray(float[][] a) {

  for (int x = 0; x < a.length; x += 1) {
    print("\n\t[" + x + "]");
    for (int y = 0; y < a[x].length; y += 1) {
      print("\n\t\t[" + a[x][y] + "]");
    }
  }
}