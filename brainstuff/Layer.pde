int LAYER_ID = 0;

class Layer {
  Layer from = null;
  Layer to = null;
  int id;

  float[] inputs;
  float[] outputs;
  float[][] weights;
  float[] delta;

  LAYERTYPE type;
  int numInputs;
  int numOutputs;



  Layer(Layer from, LAYERTYPE type, int numInputs, int numOutputs) {
    LAYER_ID += 1;
    id = LAYER_ID;
    this.numInputs = numInputs+1;
    this.numOutputs = numOutputs;
    this.type = type;
    inputs = new float[numInputs + 1];
    outputs = new float[numOutputs];
    weights = new float[numInputs + 1][numOutputs];
    this.from = from;

    delta = new float[numOutputs];

    for (int i = 0; i < weights.length; i += 1) {
      for (int j = 0; j < weights[i].length; j += 1) {
        weights[i][j] = random(-1, 1);
      }
    }
  }

  void calcDelta(float... errors) {
    for (int i = 0; i < delta.length; i += 1) {
      delta[i] = 0;
    }
    //println("calc delta " + id + " " + type);
    if (type == LAYERTYPE.OUTPUT) {
      for (int k = 0; k < outputs.length; k += 1) {
        delta[k] = dSigmoid(outputs[k]) * errors[k];
      }

      for (int i = 0; i < weights.length; i += 1) {
        for (int j = 0; j < weights[i].length; j += 1) {
          weights[i][j] += LEARNING_RATE * delta[j] * inputs[i];
        }
      }
    } else if (type == LAYERTYPE.HIDDEN) {
      if (to.type == LAYERTYPE.OUTPUT) {
        for (int i = 0; i < outputs.length; i += 1) {
          for (int j = 0; j < to.outputs.length; j += 1) {
            delta[i] += dSigmoid(outputs[i]) * to.delta[j] * weights[j][i];
          }
        }
      } else {
        for (int i = 0; i < outputs.length; i += 1) {
          for (int j = 0; j < to.delta.length; j += 1) {
            for (int k = 0; k < inputs.length; k += 1) {
              delta[i] += dSigmoid(outputs[i]) * to.delta[j] * weights[k][i];
            }
          }
        }
      }
      for (int i = 0; i < weights.length; i += 1) {
        for (int j = 0; j < weights[i].length; j += 1) {
          weights[i][j] += LEARNING_RATE * delta[j] * inputs[i];
        }
      }
    }
  }

  String toString() {
    String output = "\n";
    output += id + " in/out: " + numInputs + "," + numOutputs;
    return output;
  }



  void calc() {
    //println(type);
    if (type != LAYERTYPE.INPUT) {
      getInputs();
      resetOutput();

      for (int i = 0; i < inputs.length; i += 1) {
        for (int j = 0; j < outputs.length; j += 1) {
          outputs[j] += inputs[i] * weights[i][j];
        }
      }

      for (int j = 0; j < outputs.length; j += 1) {
        outputs[j] = sigmoid(outputs[j]);
      }
    }

    if (to != null) {
      to.calc();
    }
  }
  //util

  void draw(float x, float y) {
    String output = "";
    for (int i = 0; i < weights.length; i += 1) {
      output += "\n";
      for (int j = 0; j < weights[i].length; j += 1) {
        output += "\n(" + i + "," + j + "): " + nf(weights[i][j], 1, 2);
      }
    }

    text(output, x, y);
  }
  void getInputs() {
    if (type != LAYERTYPE.INPUT) {
      if (from != null) {
        for (int i = 0; i < from.outputs.length; i += 1) {
          inputs[i] = from.outputs[i];
        }
      }

      inputs[inputs.length - 1] = 1; //set bias
    }
  }

  void resetOutput() {
    if (type != LAYERTYPE.INPUT) {
      for (int i = 0; i < outputs.length; i += 1) {
        outputs[i] = 0;
      }
    }
  }
}