class Layer {
  float[][] weights;
  float[] values;

  Layer(int prev, int howMany) {
    weights = new float[howMany][prev];
    values = new float[howMany];

    for (int x = 0; x < weights.length; x += 1) {
      for (int y = 0; y < weights[x].length; y += 1) {
        weights[x][y] = random(-1, 1);
      }
    }
  }

  void adjustWeights() {
    for (int x = 0; x < weights.length; x += 1) {
      for (int y = 0; y < weights[x].length; y += 1) {
        weights[x][y] += random(-0.01, 0.01);
      }
    }
  }

  void adjustWeights(float factor) {
    for (int x = 0; x < weights.length; x += 1) {
      for (int y = 0; y < weights[x].length; y += 1) {
        weights[x][y] += random(0, 0.01) * factor;
      }
    }
  }
}

class Brain {
  float[] inputs;

  Layer l1, l2, out;

  Brain copy() {
    Brain copy = new Brain(inputs.length, l1.values.length, l2.values.length, out.values.length);

    for (int x = 0; x < l1.weights.length; x += 1) {
      for (int y = 0; y < l1.weights[x].length; y += 1) {
        copy.l1.weights[x][y] = l1.weights[x][y] + random(-0.01, 0.01);
        if (copy.l1.weights[x][y] < -1) copy.l1.weights[x][y] = -1;
        if (copy.l1.weights[x][y] > 1) copy.l1.weights[x][y] = 1;
      }
    }

    for (int x = 0; x < l2.weights.length; x += 1) {
      for (int y = 0; y < l2.weights[x].length; y += 1) {
        copy.l2.weights[x][y] = l2.weights[x][y] + random(-0.01, 0.01);
        if (copy.l2.weights[x][y] < -1) copy.l2.weights[x][y] = -1;
        if (copy.l2.weights[x][y] > 1) copy.l2.weights[x][y] = 1;
      }
    }

    for (int x = 0; x < out.weights.length; x += 1) {
      for (int y = 0; y < out.weights[x].length; y += 1) {
        copy.out.weights[x][y] = out.weights[x][y] + random(-0.01, 0.01);
        if (copy.out.weights[x][y] < -1) copy.out.weights[x][y] = -1;
        if (copy.out.weights[x][y] > 1) copy.out.weights[x][y] = 1;
      }
    }


    return copy;
  }


  Brain(int inputs, int l1, int l2, int out) {
    this.inputs = new float[inputs];
    this.l1 = new Layer(inputs, l1);
    this.l2 = new Layer(l1, l2);
    this.out = new Layer(l2, out);
  }

  void setInputs(float[] in) {
    for (int i = 0; i < in.length; i += 1) {
      inputs[i] = in[i];
    }
  }

  void calc() {
    for (int i = 0; i < l1.values.length; i += 1) {
      for (int j = 0; j < l1.weights[i].length; j += 1) {
        l1.values[i] = l1.weights[i][j] * inputs[j];
      }
      l1.values[i] = 1 / (1 + pow(exp(1), -l1.values[i]));
    }
    for (int i = 0; i < l2.values.length; i += 1) {
      for (int j = 0; j < l2.weights[i].length; j += 1) {
        l2.values[i] = l2.weights[i][j] * l1.values[j];
      }
      l2.values[i] = 1 / (1 + pow(exp(1), -l2.values[i]));
    }
    for (int i = 0; i < out.values.length; i += 1) {
      for (int j = 0; j < out.weights[i].length; j += 1) {
        out.values[i] = out.weights[i][j] * l2.values[j];
      }
      out.values[i] = 1 / (1 + pow(exp(1), -out.values[i]));
    }

    float r = random(0, 100);
    if (r <= 1) {
      l1.adjustWeights();
      l2.adjustWeights();
      out.adjustWeights();
    }
  }
}