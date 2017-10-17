class Brain {
  float[] inputs;
  Layer[] layers;
  Layer out;
  
  Brain(int inputs, int layers, int perLayer, int out) {
    this.inputs = new float[inputs];
    this.layers = new Layer[layers];
    for (int i = 0; i < this.layers.length; i += 1) {
      Layer l = null;
      if (i == 0) {
        l = new Layer(perLayer, inputs);
      } else {
        l = new Layer(perLayer, perLayer);
      }
      this.layers[i] = l;
    }
    this.out = new Layer(out, perLayer);
  }
  
}