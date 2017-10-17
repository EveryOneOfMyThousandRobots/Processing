enum LAYERTYPE {
  INPUT, HIDDEN, OUTPUT;
}

final float LEARNING_RATE = 0.1;


class Brain {
  Layer input;
  Layer[] hidden;
  Layer output;
  Layer firstHidden = null;
  Layer lastHidden = null;
  int numInputs, numLayers, numPerLayer, numOutputs;

  Brain(int numInputs, int numLayers, int numPerLayer, int numOutputs) {
    //set members
    this.numInputs = numInputs;
    this.numLayers = numLayers;
    this.numPerLayer = numPerLayer;
    this.numOutputs = numOutputs;
    //make layers
    input = new Layer(null, LAYERTYPE.INPUT, 1, numInputs);

    hidden = new Layer[numLayers];

    hidden[0] = new Layer(input, LAYERTYPE.HIDDEN, numInputs, numPerLayer);
    firstHidden = hidden[0];
    for (int i = 1; i < hidden.length; i += 1) {
      hidden[i] = new Layer(hidden[i-1], LAYERTYPE.HIDDEN, numPerLayer, numPerLayer);
    }
    lastHidden = hidden[hidden.length - 1];

    output = new Layer(lastHidden, LAYERTYPE.OUTPUT, numPerLayer, numOutputs);
    input.to = firstHidden;
    for (int i =0; i < hidden.length - 1; i += 1) {
      hidden[i].to = hidden[i + 1];
    }
    lastHidden.to = output;
  }
  
  void adjust(float... errors) {
    output.calcDelta(errors);
    for (int i = hidden.length - 1; i >= 0; i -= 1) {
      hidden[i].calcDelta(null);
    }
      
    
  }

  void calc(float... inputs) {
    
    if (inputs.length == input.outputs.length) {
      for (int i = 0; i < inputs.length; i += 1) {
        input.outputs[i] = inputs[i];
      } 
      input.calc();
    } else {
      println("inputs length != required length");
      stop();
      return;
    }
  }
  
  String toString() {
    String output = "\n";
    output += "in/layers/perlayer/out : " + numInputs + "," + numLayers + "," + numPerLayer + "," + numOutputs;
    output += input;
    for (Layer layer : hidden) {
      output += layer;
    }
    output += this.output;
    
    return output;
    
  }
  
  void draw() {
    float w = width / (1 + numLayers + 1);
    
    //input.draw(10, 10);
    for (int i = 0; i < hidden.length; i += 1) {
      hidden[i].draw(10+ (w * i), 10);
    }
    output.draw(width - w, 10);
  }
}