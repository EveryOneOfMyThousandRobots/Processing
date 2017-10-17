float[] in = new float[3];
float[][] nodes = new float[3][4];
float[][] weights = new float[3][4];
float[] out = new float[1];

void setup(){
  noLoop();
  
  for (int n = 0; n < nodes.length; n+= 1) {
    for (int nn = 0; nn <nodes[n].length; nn += 1) {
      nodes[n][nn] = 0;
      weights[n][nn] = random(0,1);
    }
    
  }
  printArray(nodes);
  printArray(weights);
  
}

void printArray(float[] a) {
  
  for (int n = 0; n < a.length; n += 1) {
    if (n > 0) {
      print("\t|");
    }
    print(" " + a[n]);
    if (n == a.length - 1) {
      print("\t|");
    }
  }
}

void printArray(float[][] a) {

  for (int n = 0; n < a.length; n += 1) {
    print("\n" + n + "(" + a[n].length + "):\t");
    printArray(a[n]);
    
  }
  print("\n");
}

void draw() {
}