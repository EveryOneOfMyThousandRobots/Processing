class Brain {
  float[] inputs;
  int numInputs, numLayers, numPerLayer, numOutputs;
  Layer[] layers;
  Layer output;
  Genome genome = null;

  Brain(int numInputs, int numOutputs, Genome genome) {
    this.genome = genome;

    this.numInputs = numInputs;
    this.numOutputs = numOutputs;
    this.numPerLayer = floor(map(genome.get("numPerLayer"), 0, 999, 1, 20));
    this.numLayers = floor(map(genome.get("numLayers"), 0, 999, 1, 5));
    init();
  }

  Brain(int numInputs, int numLayers, int numPerLayer, int numOutputs) {
    this.numInputs = numInputs;
    this.numLayers = numLayers;
    this.numPerLayer = numPerLayer;
    this.numOutputs = numOutputs;
    init();
  }

  void init() {
    inputs = new float[numInputs];
    layers = new Layer[numLayers];
    for (int i = 0; i < layers.length; i += 1) {
      if (i == 0) {
        layers[i] = new Layer(numPerLayer, numInputs, genome);
      } else {
        layers[i] = new Layer(numPerLayer, numPerLayer, genome);
      }
    }
    output = new Layer(numOutputs, numPerLayer, genome);
  }
  
  Brain copy(Genome genome) {
    Brain b= new Brain(numInputs, numOutputs, genome);
    
    return b;
  }

  Brain copy() {
    Brain b = new Brain(numInputs, numLayers, numPerLayer, numOutputs);
    for (int i = 0; i < layers.length; i += 1) {
      b.layers[i] = layers[i].copy();
    }

    b.output = output.copy();



    return b;
  }

  void draw() {
    float x = 30, y = 100;
    for (float f : inputs) {
      stroke(255);
      fill(map(f, -1000, 1000, 0, 255));
      Layer l = layers[0];
    }
  }



  void calc() {
    for (int l = 0; l < layers.length; l += 1) {
      if (l == 0 ) {
        layers[l].calc(inputs);
      } else {
        layers[l].calc(layers[l-1].values);
      }
    }

    output.calc(layers[layers.length-1].values);
  }

  void setInputs(float[] in) {
    for (int i = 0; i < in.length; i += 1) {
      inputs[i] = in[i];
    }
  }
}