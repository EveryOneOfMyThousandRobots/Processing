class Layer {
  float[] values;
  float[][] weights;
  int layerNum;
  DNA dna;

  Layer(int nodes, int prev, DNA dna, int layerNum) {
    this.layerNum = layerNum;
    this.dna = dna;
    this.values = new float[nodes];
    this.weights = new float[nodes][prev];
    init();
  }

  float[] addBias(float[] a) {
    a = expand(a, a.length + 1);
    a[a.length-1] = 1;
    return a;
  }

  String toString() {
    String output = "";
    for (int x = 0; x < weights.length; x += 1) {
      output += "\n";
      for (int y = 0; y < weights[x].length; y += 1) {
        output += "[" + x + "][" + y + "]:" + weights[x][y];
      }
    }
    
    return output;
  }

  void calc(float[] prev) {
    prev = addBias(prev);
    for (int v = 0; v < values.length; v += 1) {
      values[v] = 0;
      for (int w = 0; w < weights[v].length; w += 1) {
        values[v] += prev[w] * weights[v][w];
      }
      values[v] = sigmoid(values[v]);
    }
  }

  void init() {
    for (int x = 0; x < weights.length; x += 1) {
      for (int y = 0; y < weights[x].length; y += 1) {
        weights[x][y] = dna.get("weight[" + layerNum + "][" + x + "][" + y + "]", -1, 1);
      }
    }
  }
}
float EXP1 = exp(1);
float sigmoid(float x) {
  return 1 / (1 + pow(EXP1, -x));
  
}