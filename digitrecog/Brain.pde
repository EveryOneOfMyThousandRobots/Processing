class Brain {
  float[] input;
  Layer[] hidden;
  Layer output;

  Brain(int numInputs, int numHiddenLayers, int numPerHiddenLayer, int numOutputs) {
    input = new float[numInputs];
    hidden = new Layer[numHiddenLayers];
    hidden[0] = new Layer(numInputs, numPerHiddenLayer);

    for (int i = 1; i < hidden.length; i += 1) {
      hidden[i] = new Layer(numPerHiddenLayer, numPerHiddenLayer);
    }

    output = new Layer(numPerHiddenLayer, numOutputs);
  }

  void adjust(float error) {
    for (int i = 0; i < hidden.length; i += 1) {
      hidden[i].adjust(error);
    }
    output.adjust(error);
  }

  void adjust(float[] errors) {
    float[] outputDelta = new float[output.values.length];

    for (int i = 0; i < errors.length; i += 1) {
      outputDelta[i] = errors[i] - output.values[i];
    }


    for (int i = hidden.length-1; i >= 0; i -= 1) {
      float[] hiddenDelta = new float[hidden[i].values.length];

      if (i == hidden.length - 1) {
        for (int j = 0; j < hidden[i].values.length; j += 1) {
          for (int k = 0; k < output.values.length; k += 1) {
            hiddenDelta[j] += hidden[i].values[j] * outputDelta[k] * hidden[i].weights[j][k];
          }
        }
      } 
      if (i == 0) {
        for (int j = 0; j < input.length; j += 1) {
          for (int k = 0; k < hidden[i].values.length; k += 1) {
            hiddenDelta[j] += hidden[i].values[j] * outputDelta[k] * hidden[i].weights[j][k];
          }
        }
      } else {

        for (int j = 0; j < hidden[i].values.length; j += 1) {
          for (int k = 0; k < hidden[i-1].values.length; k += 1) {
            hiddenDelta[j] += sigmoid(hidden[i].values[j]) * hidden[i-1].values[k] * hidden[i].weights[j][k];
          }
        }
      }


      for (int j = 0; j < hidden[i].weights.length; j += 1) {
        for (int k = 0; k < hidden[i].weights[j].length; k += 1) {
          hidden[i].weights[j][k] += learningRate * hiddenDelta[j] * hidden[i].holdInputs[j];
        }
      }
    }
  }

  int getGuess() {
    float highest = -10000000;
    int highestIndex = -1;
    for (int j = 0; j < brain.output.values.length-1; j += 1) {
      if (brain.output.values[j] > highest) {
        highest = brain.output.values[j];
        highestIndex = j;
      }
    }

    return highestIndex;
  }

  void draw() {
    float sx = 100;
    float sy = height / 2 + 20;

    hidden[0].draw(100, height / 2);

    for (int i = 1; i < hidden.length; i += 1) {
      float xx = sx + ( (i-1) * (width / hidden.length));
      hidden[i].draw(xx, sy);
    }
    float xx = width - (width / hidden.length);
    output.draw(xx, sy);
  }

  void calc(float... inputs) {
    if (inputs.length != input.length) {
      println("error input length");
      stop();
      return;
    } else {
      for (int i = 0; i < inputs.length; i += 1) {
        input[i] = inputs[i];
      }

      hidden[0].calc(input);
      for (int i = 1; i < hidden.length; i += 1) {
        hidden[i].calc(hidden[i-1].values);
      }
      output.calc(hidden[hidden.length-1].values);
    }
  }
}