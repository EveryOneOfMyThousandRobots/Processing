class Layer {
  float [] inputs;
  float[][] weights;
  
  Layer(int nodes, int prev) {
    inputs = new float[nodes];
    weights = new float[nodes][prev];
    
    for (int x = 0; x < weights.length; x += 1) {
      for (int y = 0; y < weights[x].length; y += 1) {
        weights[x][y] = random(-1,1);
      }
    }
  }
}