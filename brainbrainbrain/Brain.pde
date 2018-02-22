

class Brain extends hasId{
  Layer input;
  Layer[] layers;
  Layer output;
  int numInputs,  numLayers,  nodesPerLayer, numOutputs;
  
  
  Brain(int numInputs, int numLayers, int nodesPerLayer, int numOutputs) {
    this.numInputs = numInputs;//+1;
    this.numLayers = numLayers;
    this.nodesPerLayer = nodesPerLayer;//+1;
    this.numOutputs = numOutputs;
    
    input = new Layer(this.numInputs);
    layers = new Layer[this.numLayers];
    for (int i = 0; i < layers.length; i += 1) {
      layers[i] = new Layer(this.nodesPerLayer);
    }
    output = new Layer(this.numOutputs);
    
    connect(input, layers[0]);
    for (int i = 0; i < layers.length -1; i += 1) {
      connect(layers[i], layers[i+1]);
    }
    connect(layers[layers.length-1], output);
    
    
    
  }
  
  void calc() {
    Layer prev = null;
    for (int i = 0; i < layers.length; i += 1) {
      Layer layer = layers[i];
      layer.calc(prev);
      prev = layer;
    }
    output.calc(prev);
  }
  
  
  void setInput(float... inputValues) {
    if (inputValues.length == numInputs) {
      for (int i = 0; i < inputValues.length; i += 1) {
        input.nodes[i].value = inputValues[i];

      }
      input.nodes[input.nodes.length-1].value = 1;
     
    }
  }
  
  void calcError(float... correctValues) {
    float[] errors = new float[numOutputs];
    for (int i = 0; i < correctValues.length; i += 1) {
      errors[i] = pow(correctValues[i] - output.nodes[i].value, 2);
    }
    printArray(errors);
    for (int i = 0; i < output.nodes.length; i += 1) {
      Node n = output.nodes[i];
      for (int j = 0; j < output.connectionsToMe.size(); j += 1) {
        Connection c = output.connectionsToMe.get(j);
        if (c.to.id == n.id) {
          c.weight += c.from.value * errors[i] * LEARNING_RATE;
        }
        
      }
    }
  }
  
  String toString() {
    String outputString = "brain (" + id + ")";
    outputString += "\ninput: " + input.toString();
    for (Layer l : layers) {
      outputString += "\n " + l.toString();
    
    }
    outputString += "\nOutput: " + output.toString();
    
    return outputString;
    
  }
  
  
}