class Brain {
  DNA dna;
  int numInputs, numLayers, numPerLayer, numOutputs;

  float[] inputs;
  Layer[] layers;
  Layer output;
  
  
  void setInputs(float... inputs) {
    for (int i = 0; i < inputs.length; i += 1) {
      this.inputs[i] = inputs[i];
    }
  }
  
  void calc() {
    for (int i = 0; i < layers.length; i += 1) {
      if (i == 0) {
        layers[i].calc(inputs);
      } else {
        layers[i].calc(layers[i-1].values);
      }
    }
    output.calc(layers[layers.length-1].values);
  }
  
  String toString() {
    String output = "";
    
    for (int i = 0; i < layers.length; i += 1) {
      output += "\n" + i + ": " + layers[i].toString();
    }
    
    output += "\noutput: " + this.output.toString();
    
    return output;
  }
  
  void mutate() {
    dna.mutate();
    for (Layer l : layers) {
      l.init();
    }
    output.init();
  }
  

  Brain(int numInputs, int  numLayers, int numPerLayer, int numOutputs) {

    this.numInputs = numInputs;
    this.numLayers = numLayers;
    this.numPerLayer = numPerLayer;
    this.numOutputs = numOutputs;

    inputs = new float[ this.numInputs +1];
    layers = new Layer[numLayers];
    dna = new DNA();
    int maxI = 0;
    for (int i = 0; i < layers.length; i += 1) {
      Layer l = null;
      if (i == 0) {
        l = new Layer(numPerLayer + 1, numInputs + 1, dna, i);
      } else {
        l = new Layer(numPerLayer + 1, numPerLayer + 1, dna, i);
      }
      layers[i] = l;
      maxI = i;
    }

    output = new Layer(numOutputs, numPerLayer + 1, dna, maxI + 1);
  }
}